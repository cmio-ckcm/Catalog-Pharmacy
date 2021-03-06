<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

<html>

<head>

<style>

body, html  { height: 100%; }
html, body, div, span, applet, object, iframe,
/*h1, h2, h3, h4, h5, h6,*/ p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
	margin: 8;
	padding: 0;
	border: 0;
	outline: 0;
	font-size: 100%;
	vertical-align: baseline;
	background: transparent;
}
body { line-height: 1; }
ol, ul { list-style: none; }
blockquote, q { quotes: none; }
blockquote:before, blockquote:after, q:before, q:after { content: ''; content: none; }
:focus { outline: 0; }
del { text-decoration: line-through; }
table {border-spacing: 0; } /* IMPORTANT, I REMOVED border-collapse: collapse; FROM THIS LINE IN ORDER TO MAKE THE OUTER BORDER RADIUS WORK */

/*------------------------------------------------------------------ */

/*This is not important*/
body{
	font-family:Arial, Helvetica, sans-serif;
	/*background: url(background.jpg);*/
	margin:10 ;
/*	width:520px;*/
}
a:link {
	color: #666;
	font-weight: bold;
	text-decoration:none;
}
a:visited {
	color: #666;
	font-weight:bold;
	text-decoration:none;
}
a:active,
a:hover {
	color: #bd5a35;
	text-decoration:underline;
}

p {
    border-style:solid;
    padding: 5;
    /*background-color: rgba(204, 98, 141, 0.11);*/
    background-color: #fbfbfb;	
}

.info {
    background-color: #fbfbfb;
}
.important {
/*    background-color: yellow;*/
    background-color: rgba(218, 214, 33, 0.34);
}

Table Style - This is what you want
------------------------------------------------------------------ */
table a:link {
	color: #666;
	font-weight: bold;
	text-decoration:none;
}
table a:visited {
	color: #999999;
	font-weight:bold;
	text-decoration:none;
}
table a:active,
table a:hover {
	color: #bd5a35;
	text-decoration:underline;
}
table {
	font-family:Arial, Helvetica, sans-serif;
	color:#666;
/*	font-size:12px;*/
	/*text-shadow: 1px 1px 0px #fff;*/
	background:#eaebec;
	margin:20px;
	border:#ccc 1px solid;

	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;

	-moz-box-shadow: 0 1px 2px #d1d1d1;
	-webkit-box-shadow: 0 1px 2px #d1d1d1;
	box-shadow: 0 1px 2px #d1d1d1;
}
table th {
	padding:4px 27px 4px 22px;
	border-top:1px solid #fafafa;
	border-bottom:1px solid #e0e0e0;

	background: #ededed;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
	background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
}
table th:first-child{
	text-align: left;
	padding-left:20px;
}
table tr:first-child th:first-child{
	-moz-border-radius-topleft:3px;
	-webkit-border-top-left-radius:3px;
	border-top-left-radius:3px;
}
table tr:first-child th:last-child{
	-moz-border-radius-topright:3px;
	-webkit-border-top-right-radius:3px;
	border-top-right-radius:3px;
}
table tr{
	text-align: left;
	padding-left:20px;
}
table tr td:first-child{
	text-align: left;
	padding-left:20px;
	border-left: 0;
}
table tr td {
	border-top: 1px solid #ffffff;
	border-bottom:1px solid #e0e0e0;
	border-left: 1px solid #e0e0e0;
	
	background: #fafafa;
	background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
	background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}
table tr.even td{
	background: #f6f6f6;
	background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
	background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
}
table tr:last-child td{
	border-bottom:0;
}
table tr:last-child td:first-child{
	-moz-border-radius-bottomleft:3px;
	-webkit-border-bottom-left-radius:3px;
	border-bottom-left-radius:3px;
}
table tr:last-child td:last-child{
	-moz-border-radius-bottomright:3px;
	-webkit-border-bottom-right-radius:3px;
	border-bottom-right-radius:3px;
}
table tr:hover td{
/*	background: #f2f2f2;
	background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
	background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);	*/
}


</style>

</head>

  <body>
    <h2><xsl:value-of select="/request/@name"/></h2>


    <table border="1">
    <tr>
      <th>Division</th>
      <th>Order Type</th>
      <th>Synonym</th>
      <th>Ordered By</th>
      <th>Frequency</th>
      <th>Order Indications</th>

      <th>CDS</th>
      <th>Clinician Instructions</th>
      <th>pCLOCD/LOINC</th>
	  <th>Mapping Name</th>
    </tr>

    <tr valign="top">
      <td>
        <xsl:for-each select="/request/division/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>
      <td>
        <xsl:for-each select="/request/ordertype/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>
      <td>
        <xsl:for-each select="/request/synonym/*">
            <p><xsl:value-of select ="."/></p>
        </xsl:for-each>
      </td>
      <td>
        <xsl:for-each select="/request/orderedby/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>

      <td>
        <xsl:for-each select="/request/frequency/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>

      <td>
        <xsl:for-each select="/request/orderindications/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>

      <td>
        <xsl:for-each select="/request/cds/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>
      <td>
        <xsl:for-each select="/request/clinicianinstructions/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>

      <td>
        <xsl:for-each select="/request/pclocd_loinc/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>

	  
      <td>
        <xsl:for-each select="/request/mappingname/*">
            <p><xsl:value-of select ="."/></p>
         </xsl:for-each>
      </td>

	  
     </tr>

    </table>

    <table border="1">
        <xsl:for-each select="/request/orderelement">
		   <xsl:choose>
		   <xsl:when test="@section">
			   <tr><th bgcolor="#ffffff">
			   
				 <xsl:value-of select ="@section"/>
		        
				</th>
				<th></th>
			   </tr>	 
		   </xsl:when>
		   <xsl:otherwise>
			<tr>
			    <th>
					<xsl:value-of select ="@element-field"/>
				</th>
				<td>
					<p><xsl:value-of select ="@element-answer"/></p>
				</td>
			</tr> 
			</xsl:otherwise>
			</xsl:choose>
         </xsl:for-each>
   </table>



	
	

  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
