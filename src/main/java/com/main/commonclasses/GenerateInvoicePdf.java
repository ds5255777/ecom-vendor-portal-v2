package com.main.commonclasses;

import java.io.FileNotFoundException;

import org.springframework.stereotype.Component;

import com.itextpdf.kernel.color.Color;
import com.itextpdf.kernel.color.DeviceRgb;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.border.Border;
import com.itextpdf.layout.border.SolidBorder;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;

@Component
public class GenerateInvoicePdf {
	
	/*
	 * public static void main(String[] args) throws FileNotFoundException {
	 * GenerateInvoicePdf gp=new GenerateInvoicePdf();
	 * 
	 * gp.generateInvoicePDF(new InvoiceGenerationEntity()); }
	 */

	public void generateInvoicePDF(InvoiceGenerationEntity obj) throws FileNotFoundException {
					
		String path = "C:\\1.BPAAS\\inv\\invoice.pdf";
		PdfWriter pdfWriter = new PdfWriter(path);
		PdfDocument pdfDocument = new PdfDocument(pdfWriter);
		pdfDocument.setDefaultPageSize(PageSize.A4);
		Document document = new Document(pdfDocument);

		float threecol = 285f;
		float fourcol = 80f;
		float twocol = 285f;
		float twocol150 = twocol + 150f;
		float twocol200 = twocol = 200f;
		float twolcol200width[] = { twocol200, twocol };
		float twocolumnwidth[] = { twocol150, twocol };
		float threecolumnwidth[] = { threecol, threecol, threecol, threecol };
		float fourthcoumnwidth[] = { fourcol, fourcol, fourcol, fourcol, fourcol, fourcol, fourcol, fourcol, fourcol,
				fourcol, fourcol };
		float fullwidth[] = { threecol * 8 };
		Paragraph onespace = new Paragraph("\n");

		Table table = new Table(twocolumnwidth);
		Color color1 = new DeviceRgb(0, 123, 255);
		table.addCell(new Cell().add("INVOICE-PROCESS").setFontSize(16f).setFontColor(Color.WHITE)
				.setBorder(Border.NO_BORDER).setBold());
		table.setBackgroundColor(color1, 0.7f);

		// table.setBackgroundColor(Color.BLUE,0.7f);
		// table.setBackgroundColor(C)

		Table nestedtable = new Table(new float[] { twocol / 2, twocol / 2 });
		nestedtable.addCell(getHeaderTextCell("Invoice No.").setFontColor(Color.WHITE).setBorder(Border.NO_BORDER));
		nestedtable.addCell(getHeaderTextCellValue(obj.getEcomInvoiceNumber()).setFontColor(Color.WHITE).setBorder(Border.NO_BORDER));
//     nestedtable.addCell(getHeaderTextCell("Invoice Date "));
//     nestedtable.addCell(getHeaderTextCellValue("01/04/2022"));
		table.addCell(new Cell().add(nestedtable).setBorder(Border.NO_BORDER));

		// custom border

		Border border = new SolidBorder(Color.GRAY, 2f);
		Table divider = new Table(fullwidth);
		divider.setBorder(border);

		document.add(table);
		document.add(onespace);
		document.add(divider);
		document.add(onespace);

		Table twoColTable = new Table(fullwidth);
		twoColTable.setBackgroundColor(color1, 0.7f);

		// twoColTable.setBackgroundColor(Color.BLUE,0.7f);

		twoColTable.addCell(getBasicDetailCell("BASIC DETAILS").setFontColor(Color.WHITE));
		document.add(twoColTable.setMarginBottom(12f));

		Table twoColTable2 = new Table(threecolumnwidth);
		// header
		twoColTable2.addCell(getCell10Left("Partner Name", true));
		twoColTable2.addCell(getCell10Left(obj.getVendorName(), false));
		twoColTable2.addCell(getCell10Left("Partner Code", true));
		twoColTable2.addCell(getCell10Left(obj.getVendorCode(), false));
		twoColTable2.addCell(getCell10Left("Invoice No.", true));
		twoColTable2.addCell(getCell10Left(obj.getInvoiceNumber(), false));
		twoColTable2.addCell(getCell10Left("Invoice Date", true));
		twoColTable2.addCell(getCell10Left(obj.getInvoiceDate(), false));
		twoColTable2.addCell(getCell10Left("Site Name", true));
		twoColTable2.addCell(getCell10Left(obj.getSiteName(), false));
		twoColTable2.addCell(getCell10Left("Invoice Receiving Date", true));
		twoColTable2.addCell(getCell10Left(obj.getInvoiceReceivingDate(), false));
		twoColTable2.addCell(getCell10Left("Invoice Currency", true));
		twoColTable2.addCell(getCell10Left(obj.getInvoiceCurrency(), false));
		twoColTable2.addCell(getCell10Left("Taxable Amount", true));
		twoColTable2.addCell(getCell10Left(obj.getTaxableAmount(), false));
		twoColTable2.addCell(getCell10Left("Tax Amount", true));
		twoColTable2.addCell(getCell10Left(obj.getTaxAmount(), false));
		twoColTable2.addCell(getCell10Left("Invoice Amount", true));
		twoColTable2.addCell(getCell10Left(obj.getInvoiceAmount(), false));

		// values

		document.add(twoColTable2);

//     // drawing line after site details
//     Table dividerTable2 = new Table(fullwidth);
//     Border border1 = new SolidBorder(Color.GRAY, 1f);
//     document.add(dividerTable2.setBorder(border1));

		// line items

		document.add(onespace);
		Table twoColTable3 = new Table(fullwidth);
		twoColTable3.addCell(getBasicDetailCell("Line Item's").setFontColor(Color.WHITE));
		twoColTable3.setBackgroundColor(color1, 0.7f);
		document.add(twoColTable3.setMarginBottom(12f));

		Table twoColTable4 = new Table(fourthcoumnwidth);
		// twoColTable4.setBackgroundColor(Color.BLACK,0.7f);

		twoColTable4.addCell(getCell10Left("Run Type", true));
		twoColTable4.addCell(getCell10Left("Standard KM", true));
		twoColTable4.addCell(getCell10Left("Rate per km", true));
		twoColTable4.addCell(getCell10Left("Current Fuel Rate", true));
		twoColTable4.addCell(getCell10Left("FS Base Rate", true));
		twoColTable4.addCell(getCell10Left("FS Diff", true));
		twoColTable4.addCell(getCell10Left("Basic Freight", true));
		twoColTable4.addCell(getCell10Left("FS", true));
		twoColTable4.addCell(getCell10Left("Actual KM", true));
		twoColTable4.addCell(getCell10Left("Total Freight", true));
		twoColTable4.addCell(getCell10Left("Line Level Description", true));

		// values
		twoColTable4.addCell(getCell10Left("Scheduled", false));
		twoColTable4.addCell(getCell10Left("456", false));
		twoColTable4.addCell(getCell10Left("22", false));
		twoColTable4.addCell(getCell10Left("94", false));
		twoColTable4.addCell(getCell10Left("20", false));
		twoColTable4.addCell(getCell10Left("45", false));
		twoColTable4.addCell(getCell10Left("40", false));
		twoColTable4.addCell(getCell10Left("79", false));
		twoColTable4.addCell(getCell10Left("500", false));
		twoColTable4.addCell(getCell10Left("7900", false));
		twoColTable4.addCell(getCell10Left("Round", false));

		// adding 2nd value

		twoColTable4.addCell(getCell10Left("Scheduled", false));
		twoColTable4.addCell(getCell10Left("765", false));
		twoColTable4.addCell(getCell10Left("21", false));
		twoColTable4.addCell(getCell10Left("96", false));
		twoColTable4.addCell(getCell10Left("18", false));
		twoColTable4.addCell(getCell10Left("65", false));
		twoColTable4.addCell(getCell10Left("70", false));
		twoColTable4.addCell(getCell10Left("69", false));
		twoColTable4.addCell(getCell10Left("700", false));
		twoColTable4.addCell(getCell10Left("9900", false));
		twoColTable4.addCell(getCell10Left("Round", false));

		// adding 3rd value

		twoColTable4.addCell(getCell10Left("adhoc", false));
		twoColTable4.addCell(getCell10Left("965", false));
		twoColTable4.addCell(getCell10Left("23", false));
		twoColTable4.addCell(getCell10Left("87", false));
		twoColTable4.addCell(getCell10Left("34", false));
		twoColTable4.addCell(getCell10Left("85", false));
		twoColTable4.addCell(getCell10Left("90", false));
		twoColTable4.addCell(getCell10Left("6", false));
		twoColTable4.addCell(getCell10Left("1056", false));
		twoColTable4.addCell(getCell10Left("12768", false));
		twoColTable4.addCell(getCell10Left("Round", false));

		// adding 4th value

		twoColTable4.addCell(getCell10Left("adhoc", false));
		twoColTable4.addCell(getCell10Left("1897", false));
		twoColTable4.addCell(getCell10Left("23", false));
		twoColTable4.addCell(getCell10Left("78", false));
		twoColTable4.addCell(getCell10Left("65", false));
		twoColTable4.addCell(getCell10Left("85", false));
		twoColTable4.addCell(getCell10Left("90", false));
		twoColTable4.addCell(getCell10Left("43", false));
		twoColTable4.addCell(getCell10Left("9800", false));
		twoColTable4.addCell(getCell10Left("23453", false));
		twoColTable4.addCell(getCell10Left("Round", false));

		document.add(twoColTable4);

		document.add(onespace);

		Table table4 = new Table(twocolumnwidth);
		// table4.addCell(new
		// Cell().add("Total").setFontSize(12f).setFontColor(Color.WHITE).setBorder(Border.NO_BORDER)
		// .setBold());
		table4.addCell(getCell10Left("Total ", true).setBackgroundColor(color1).setFontColor(Color.WHITE)
				.setBorder(Border.NO_BORDER));

		table4.addCell(getCell10Left("107546 ", false).setBackgroundColor(color1).setFontColor(Color.WHITE)
				.setBorder(Border.NO_BORDER));
		table4.setBackgroundColor(color1, 0.7f);

		document.add(table4);

		System.out.println("pdf created");

		document.close();

	}

	static Cell getHeaderTextCell(String textValue) {
		return new Cell().add(textValue).setBold().setTextAlignment(TextAlignment.RIGHT);

	}

	static Cell getHeaderTextCellValue(String textValue) {
		return new Cell().add(textValue).setTextAlignment(TextAlignment.RIGHT);

	}

	static Cell getBasicDetailCell(String textValue) {
		return new Cell().add(textValue).setFontSize(14f).setTextAlignment(TextAlignment.LEFT);
	}

	static Cell getCell10Left(String textValue, Boolean isBold) {

		Cell myCell = new Cell().add(textValue).setFontSize(12f).setBackgroundColor(Color.WHITE)
				.setTextAlignment(TextAlignment.LEFT);
		return isBold ? myCell.setBold() : myCell;
	}

}
