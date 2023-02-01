<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="#all"
   version="3.0">
   
   <xsl:template match="text()">
      <xsl:choose>
         <xsl:when test="preceding-sibling::node()[1][self::tei:seg]
            and following-sibling::node()[1][self::tei:note]
            and normalize-space() eq ''" />
         <xsl:when test="preceding-sibling::node()[1][self::tei:milestone]
            and following-sibling::node()[1][self::tei:lb]
            and normalize-space() eq ''" />
         <xsl:when test="parent::tei:w">
            <xsl:value-of select="normalize-space()" />
         </xsl:when>
         <xsl:when test="normalize-space() eq ''
            and (parent::tei:note or parent::tei:bibl or parent::tei:ref)
            and not(preceding-sibling::node())" />
         <xsl:when test="parent::tei:choice" />
         <xsl:otherwise>
            <xsl:sequence select="." />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="@* | *">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" />
      </xsl:copy>
   </xsl:template>
   
</xsl:stylesheet>