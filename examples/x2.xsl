<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:output method="text" />
  
<!--  <xsl:template match="tei:facsimile" />-->
  
  <!--<xsl:template match="tei:TEI">
    <TEI>
      <element>
        <xsl:text>asdf</xsl:text>
      </element>
      <element>
        
      </element>
    </TEI>
  </xsl:template>-->
  
  <!--<xsl:template match="tei:TEI">
    \begin{document}
    <xsl:apply-templates />
    \end{document}
  </xsl:template>-->
  
  <!--<xsl:template match="tei:TEI">
    <xsl:text>\begin{document}</xsl:text>
    <xsl:apply-templates />
    <xsl:text>
\end{document}</xsl:text>
  </xsl:template>-->
  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>