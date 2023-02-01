<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:template match="tei:TEI">
    <xsl:apply-templates select="tei:text/tei:body" />
  </xsl:template>
  
  <xsl:template match="tei:div">
    <div>
      <xsl:if test="tei:pb">
        <xsl:attribute name="type">pagebreak</xsl:attribute>
      </xsl:if>
      <xsl:if test="tei:ab">
        <xsl:attribute name="subtype" select="count(tei:ab)" />
      </xsl:if>
      <xsl:apply-templates select="@* | node()" />
    </div>
  </xsl:template>
  
  <xsl:template match="tei:ab">
    <ab>
      <xsl:choose>
        <xsl:when test="tei:fw">
          <xsl:attribute name="type">fw</xsl:attribute>
        </xsl:when>
        <xsl:when test="tei:num">
          <xsl:attribute name="type">num</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type">none</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:apply-templates select="//tei:title[@type = 'main']" />
    </ab>
  </xsl:template>
  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <!--<xsl:apply-templates select="@* | node()" />-->
      <xsl:apply-templates select="*" />
<!--      <xsl:text>Ende</xsl:text>-->
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>