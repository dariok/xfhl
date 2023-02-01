<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="#all"
   version="3.0">
   
   <xsl:output indent="1" />
   
   <!--<xsl:template match="tei:list">
      <list>
         <xsl:apply-templates select="tei:item">
<!-\-            <xsl:sort select="number()" order="descending"/>-\->
            <xsl:sort select="." />
         </xsl:apply-templates>
      </list>
   </xsl:template>-->
   
   <xsl:template match="tei:list">
      <list>
         <xsl:for-each-group select="tei:item" group-by="substring(., 1, 1)">
            <xsl:sort select="substring(., 1, 1)" />
            
            <xsl:text>
               </xsl:text>
            <label>
               <xsl:sequence select="substring(., 2, 1)" />
            </label>
            <xsl:apply-templates select="current-group()">
               <xsl:sort />
            </xsl:apply-templates>
         </xsl:for-each-group>
      </list>
   </xsl:template>
   
   <xsl:template match="tei:ab">
      <ab>
         <xsl:for-each-group select="node()" group-starting-with="tei:cb">
            <p>
               <xsl:sequence select="current-group()[position() gt 1]" />
            </p>
         </xsl:for-each-group>
      </ab>
   </xsl:template>
   
   <xsl:template match="tei:front/tei:p">
      <p>
         <xsl:for-each-group select="*" group-adjacent="@rend">
            <hi rend="{current-grouping-key()}">
               <xsl:sequence select="current-group()/node()" />
            </hi>
         </xsl:for-each-group>
      </p>
   </xsl:template>
   
   <xsl:template match="@* | node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" />
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
