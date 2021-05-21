<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:output method="text" />
  
  <xsl:template match="/">
    <xsl:text>\chapter{</xsl:text>
    <xsl:value-of select="//tei:titleStmt/tei:title[2]" />
    <xsl:text>}</xsl:text>
    
    <xsl:apply-templates select="//tei:body/tei:div" />
  </xsl:template>
  
  <xsl:template match="tei:div">
    <xsl:text>

</xsl:text>
    <xsl:apply-templates select="*" />
  </xsl:template>
  
  <xsl:template match="tei:head">
    <xsl:variable name="lvl" select="count(ancestor::tei:div)" />
    <xsl:choose>
      <xsl:when test="$lvl eq 1">\section{</xsl:when>
      <xsl:when test="$lvl eq 2">\subsection{</xsl:when>
      <xsl:when test="$lvl eq 3">\subsubsection{</xsl:when>
    </xsl:choose>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:p">
    <xsl:text>
\par </xsl:text>
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="tei:figure">
    <xsl:text>
  \begin{figure}</xsl:text>
    <xsl:apply-templates select="tei:graphic" />
    <xsl:apply-templates select="tei:figDesc" />
    <xsl:text>
  \end{figure}</xsl:text>
  </xsl:template>
  <xsl:template match="tei:graphic">
    <xsl:text>
    \includegraphics[width=\linewidth]{</xsl:text>
    <xsl:value-of select="replace(substring(@url, 4), '\.svg', '.jpg')"/>
    <xsl:text>}</xsl:text>
  </xsl:template>
  <xsl:template match="tei:figDesc">
    <xsl:text>
    \caption{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>
</xsl:stylesheet>