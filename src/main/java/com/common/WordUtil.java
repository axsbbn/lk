package com.common;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlToken;
import org.openxmlformats.schemas.drawingml.x2006.main.CTNonVisualDrawingProps;
import org.openxmlformats.schemas.drawingml.x2006.main.CTPositiveSize2D;
import org.openxmlformats.schemas.drawingml.x2006.wordprocessingDrawing.CTInline;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 导出word工具类
 */
public class WordUtil {
    private static Log log = LogFactory.getLog(WordUtil.class);
    /**
     * 装载模板所对应的对象
     * @param object
     * @return map
     */
    public static Map<String,Object> setMapObject(Object object){
        Map<String,Object> mapObject = new HashMap<String,Object>();
        if(object != null){
            Field[] fields = object.getClass().getDeclaredFields();
            log.info("fields" + fields.length);
            for(Field field : fields){
                try {
                    field.setAccessible(true);
                    String str = "${" + field.getName() + "}";
                    Object objValue = field.get(object);
                    if(objValue != null){
                        log.info(str + "----" + objValue.toString());
                        mapObject.put(str, objValue);
                    }else{
                        mapObject.put(str, "");
                    }
                } catch(Exception e) {
                    log.error("模板对象出现错误", e);
                }
            }
        } else {
            log.error("模板对象不是对应的一个类对象");
        }
        return mapObject;
    }

    /**
     * 根据指定的参数值、模板，生成 word 文档
     * @param param 需要替换的变量
     * @param template 模板
     * @return XWPFDocument
     * @throws IOException
     * @throws InvalidFormatException
     */
    public static XWPFDocument generateWord(Map<String, Object> param, String template) throws IOException, InvalidFormatException {
        if(param == null || template == null){
            return null ;
        }
        XWPFDocument xwpfDocument = null;
        log.info("解析的模版为：" + template);
        try {
            OPCPackage pack = POIXMLDocument.openPackage(template);
            xwpfDocument = new XWPFDocument(pack);
            if (param.size() > 0) {
                //处理段落
                List<XWPFParagraph> paragraphList = xwpfDocument.getParagraphs();
                processParagraphs(paragraphList, param, xwpfDocument);
                //处理表格
                Iterator<XWPFTable> it = xwpfDocument.getTablesIterator();
                while (it.hasNext()) {
                    XWPFTable table = it.next();
                    List<XWPFTableRow> rows = table.getRows();
                    for (XWPFTableRow row : rows) {
                        List<XWPFTableCell> cells = row.getTableCells();
                        for (XWPFTableCell cell : cells) {
                            List<XWPFParagraph> paragraphListTable = cell.getParagraphs();
                            processParagraphs(paragraphListTable, param, xwpfDocument);
                        }
                    }
                }
            }
        } catch (IOException e) {
            log.error("文件处理异常", e);
            throw(e);
        }catch (InvalidFormatException e) {
            log.error("文档中内容处理异常", e);
            throw(e);
        }
        return xwpfDocument;
    }

    /**
     * 处理段落
     * @param paragraphList
     * @param param
     * @param doc
     * @throws InvalidFormatException
     * @throws FileNotFoundException
     */
    public static void processParagraphs(List<XWPFParagraph> paragraphList, Map<String, Object> param, XWPFDocument doc) throws InvalidFormatException, FileNotFoundException{
        if(paragraphList != null && paragraphList.size() > 0){
            for(XWPFParagraph paragraph : paragraphList){
                List<XWPFRun> runs = paragraph.getRuns();
                for (XWPFRun run : runs) {
                    String text = run.getText(0);
                    if(text != null){
                        boolean isSetText = false;
                        for (Map.Entry<String, Object> entry : param.entrySet()) {
                            String key = entry.getKey();
                            if(text.indexOf(key) != -1){
                                isSetText = true;
                                Object value = entry.getValue();
                                if (value instanceof String) {//文本替换
                                    log.info(key + "模板中模要转化属性对应的值:" + value);
                                    text = text.replace(key, value.toString());
                                } else if (value instanceof Map) {//图片替换
                                    text = text.replace(key, "");
                                    Map pic = (Map)value;
                                    int width = Integer.parseInt(pic.get("width").toString());
                                    int height = Integer.parseInt(pic.get("height").toString());
                                    int picType = getPictureType(pic.get("type").toString());
                                    String byteArray = (String) pic.get("imgPath");
                                    log.info("模板中模要转化的图片" + byteArray);
                                    CTInline inline = run.getCTR().addNewDrawing().addNewInline();
                                    insertPicture(doc,byteArray,inline, width, height);
                                }
                            }
                        }
                        if(isSetText){
                            run.setText(text,0);
                        }
                    }
                }
            }
        }
    }

    /**
     * 根据图片类型，取得对应的图片类型代码
     * @param picType
     * @return int
     */
    private static int getPictureType(String picType){
        int res = XWPFDocument.PICTURE_TYPE_PICT;
        if(picType != null){
            if(picType.equalsIgnoreCase("png")){
                res = XWPFDocument.PICTURE_TYPE_PNG;
            }else if(picType.equalsIgnoreCase("dib")){
                res = XWPFDocument.PICTURE_TYPE_DIB;
            }else if(picType.equalsIgnoreCase("emf")){
                res = XWPFDocument.PICTURE_TYPE_EMF;
            }else if(picType.equalsIgnoreCase("jpg") || picType.equalsIgnoreCase("jpeg")){
                res = XWPFDocument.PICTURE_TYPE_JPEG;
            }else if(picType.equalsIgnoreCase("wmf")){
                res = XWPFDocument.PICTURE_TYPE_WMF;
            }
        }
        return res;
    }

    /**
     * 将输入流中的数据写入字节数组
     * @param inputStream
     * @param isClose
     * @return
     */
    public static byte[] inputStream2ByteArray(InputStream inputStream,boolean isClose){
        byte[] byteArray = null;
        try {
            int total = inputStream.available();
            byteArray = new byte[total];
            inputStream.read(byteArray);
        } catch (IOException e) {
            log.error("IO异常",e);
        } finally {
            if(isClose){
                try {
                    inputStream.close();
                } catch (Exception e2) {
                    log.debug("关闭流失败");
                }
            }
        }
        return byteArray;
    }

    /**
     *
     * @param document
     * @param filePath
     * @param inline
     * @param width
     * @param height
     * @throws InvalidFormatException
     * @throws FileNotFoundException
     */
    private static void insertPicture(XWPFDocument document, String filePath, CTInline inline, int width, int height) throws InvalidFormatException, FileNotFoundException {
        document.addPictureData(new FileInputStream(filePath), XWPFDocument.PICTURE_TYPE_PNG);
        int id = document.getAllPictures().size() - 1;
        final int EMU = 9525;
        width *= EMU;
        height *= EMU;
//        String blipId = document.getAllPictures().get(id).getPackageRelationship().getId();
        Integer blipIdString = document.getAllPictures().get(id).getPictureType();
        String blipId = blipIdString.toString();
        String picXml = getPicXml(blipId, width, height);
        XmlToken xmlToken = null;
        try {
            xmlToken = XmlToken.Factory.parse(picXml);
        } catch (XmlException xe) {
            log.error("XmlException",xe);
        }
        inline.set(xmlToken);
        inline.setDistT(0);
        inline.setDistB(0);
        inline.setDistL(0);
        inline.setDistR(0);
        CTPositiveSize2D extent = inline.addNewExtent();
        extent.setCx(width);
        extent.setCy(height);
        CTNonVisualDrawingProps docPr = inline.addNewDocPr();
        docPr.setId(id);
        docPr.setName("IMG_" + id);
        docPr.setDescr("IMG_" + id);
    }

    /**
     * get the xml of the picture
     * @param blipId
     * @param width
     * @param height
     * @return
     */
    private static String getPicXml(String blipId, int width, int height) {
        String picXml =
                "" + "<a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">" +
                        "   <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" +
                        "      <pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" +
                        "         <pic:nvPicPr>" + "            <pic:cNvPr id=\"" + 0 +
                        "\" name=\"Generated\"/>" + "            <pic:cNvPicPr/>" +
                        "         </pic:nvPicPr>" + "         <pic:blipFill>" +
                        "            <a:blip r:embed=\"" + blipId +
                        "\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\"/>" +
                        "            <a:stretch>" + "               <a:fillRect/>" +
                        "            </a:stretch>" + "         </pic:blipFill>" +
                        "         <pic:spPr>" + "            <a:xfrm>" +
                        "               <a:off x=\"0\" y=\"0\"/>" +
                        "               <a:ext cx=\"" + width + "\" cy=\"" + height +
                        "\"/>" + "            </a:xfrm>" +
                        "            <a:prstGeom prst=\"rect\">" +
                        "               <a:avLst/>" + "            </a:prstGeom>" +
                        "         </pic:spPr>" + "      </pic:pic>" +
                        "   </a:graphicData>" + "</a:graphic>";
        return picXml;
    }
}
