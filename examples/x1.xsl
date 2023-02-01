<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:template match="/">
    <xsl:text>
</xsl:text>
    <xsl:apply-templates />
    <xsl:text>
</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:title">
    <title>
      <xsl:attribute name="type">main</xsl:attribute>
      <xsl:apply-templates />
    </title>
  </xsl:template>
  
  <xsl:template match="tei:teiHeader//tei:p">
    <p>Hallo!</p>
  </xsl:template>
  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>