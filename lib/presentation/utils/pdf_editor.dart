import 'dart:io';

import 'package:flutter/services.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/presentation/model/result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:collection/collection.dart';

class PdfEditor {
  Future<File> getSolutionPdf(List<Result> results) async {
    final PdfDocument document = PdfDocument();

    final font = await _getFont();

    final PdfPage page = document.pages.add();

    final PdfLayoutResult headerLayoutResult = _appendHeader(document, page, font);

    final PdfLayoutResult sheetLayoutResult = _appendSheetTable(font, results, page, headerLayoutResult);

    _appendDetailTable(font, results, page, sheetLayoutResult);

    for (final result in results) {
      final PdfGrid grid = PdfGrid();

      grid.columns.add(count: 1);

      final newPage = document.pages.add();
      final pageHeight = newPage.size.height;
      final coeficient = result.sheet.width / pageHeight;

      for (final detail in result.details) {
        final PdfGridRow row = grid.rows.add();
        final PdfGridCell cell = row.cells[0];
        cell.value = "${detail.totalWidth}";
        cell.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        cell.style.font = font;
        cell.style.cellPadding = PdfPaddings(
          top: detail.totalWidth / coeficient / 3,
          bottom: detail.totalWidth / coeficient / 3,
        );
      }

      if (result.remainder > 0) {
        final PdfGridRow row = grid.rows.add();
        final PdfGridCell cell = row.cells[0];
        cell.value = "Остаток";
        cell.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        cell.style.font = font;
        cell.style.textBrush = PdfSolidBrush(PdfColor(255, 0, 0));
        cell.style.cellPadding = PdfPaddings(
          top: result.remainder / coeficient / 3,
          bottom: result.remainder / coeficient / 3,
        );
      }

      grid.draw(page: newPage);
    }

    File file = await _createFile(document);

    document.dispose();

    return file;
  }

  PdfLayoutResult _appendHeader(PdfDocument document, PdfPage page, PdfFont font) {
    return PdfTextElement(
      text: 'Схема №${document.hashCode}',
      font: font,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    ).draw(
        page: page,
        bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
  }

  PdfLayoutResult _appendSheetTable(PdfFont font, List<Result> results, PdfPage page, PdfLayoutResult layoutResult) {
    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 2);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Лист';
    headerRow.cells[1].value = 'Кол-во';
    headerRow.style.font = font;

    PdfGridRow row = grid.rows.add();
    row.style.font = font;
    row.cells[0].value = results.firstOrNull?.sheet.name ?? "";
    row.cells[1].value = '${results.length}';

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    return grid.draw(page: page, bounds: Rect.fromLTRB(0, layoutResult.bounds.bottom + 10, 0, 0))!;
  }

  PdfLayoutResult _appendDetailTable(PdfFont font, List<Result> results, PdfPage page, PdfLayoutResult layoutResult) {
    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 2);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Деталь';
    headerRow.cells[1].value = 'Кол-во';
    headerRow.style.font = font;

    final details = [];

    for (final resultItem in results) {
      details.addAll(resultItem.details);
    }

    final Map<Detail, int> groupedDetails = {};

    for (final detail in details..sort((a, b) => a.name.compareTo(b.name))) {
      if (groupedDetails.containsKey(detail)) {
        groupedDetails[detail] = (details.where((element) => element.id == detail.id)).length;
      } else {
        groupedDetails.addEntries([
          MapEntry(detail, (details.where((element) => element.id == detail.id)).length),
        ]);
      }
    }

    for (final detailEntry in groupedDetails.entries) {
      PdfGridRow row = grid.rows.add();
      row.style.font = font;
      row.cells[0].value = detailEntry.key.name;
      row.cells[1].value = '${detailEntry.value}';
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    return grid.draw(page: page, bounds: Rect.fromLTRB(0, layoutResult.bounds.bottom + 10, 0, 0))!;
  }

  Future<File> _createFile(PdfDocument document) async {
    Directory filesDirectory = Directory("${(await getApplicationDocumentsDirectory()).path}/files");

    if (!filesDirectory.existsSync()) {
      filesDirectory.createSync(recursive: true);
    }

    final file = await File('${filesDirectory.path}/${document.hashCode}.pdf').writeAsBytes(await document.save());
    return file;
  }

  Future<PdfFont> _getFont() async {
    try {
      final Uint8List fontData = (await _getFileAssets(path: "assets/fonts/Inter-Black.ttf")).readAsBytesSync();
      return PdfTrueTypeFont(fontData, 14);
    } catch (e) {
      return await _getFont();
    }
  }

  Future<File> _getFileAssets({required String path}) async {
    final directory = await getApplicationDocumentsDirectory();

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final file = File("${directory.path}/${path.split("/").last}");

    final ByteData byteData = await rootBundle.load(path);

    file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
