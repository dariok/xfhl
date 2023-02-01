<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <!-- Ziel: Erstellung einer HTML-Ansicht
       Ausgabe-Methode mittels xsl:output festlegen -->
  <xsl:output method="html" />
  
  <!-- Ausgabe von ganzen HTML-Seiten, also nicht für ein
       CMS oder andere Umgebung -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:text>Artikel „</xsl:text>
          <xsl:apply-templates select="//tei:titleStmt/tei:title[@type = 'main']" />
          <xsl:text>“</xsl:text>
        </title>
      </head>
      <body>
        <article>
          <nav>
            <xsl:apply-templates select="//tei:body/tei:div" mode="nav" />
          </nav>
          <header>
            <h1>
              <xsl:apply-templates select="//tei:titleStmt/tei:title[@type = 'main']"/>
              <xsl:apply-templates select="//tei:titleStmt/tei:title[@type = 'sub']"/>
            </h1>
            <xsl:apply-templates select="//tei:titleStmt/tei:author" />
          </header>
          
          <xsl:apply-templates select="//tei:text/tei:body" />
          
          <!-- mehrere section, je nach Bedarf -->
          <aside>
            <xsl:apply-templates select="//tei:text/tei:back" />
          </aside>
          <footer>
            <!-- Angaben zu Lizenzen etc. -->
          </footer>
        </article>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:title">
    <xsl:if test="not(@type = 'main')">
      <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="tei:author">
    <span class="author">
      <xsl:apply-templates select="tei:name" />
    </span>
  </xsl:template>
  <xsl:template match="tei:name">
    <xsl:apply-templates select="tei:surname" />
    <xsl:text>, </xsl:text>
    <xsl:apply-templates select="tei:forename" />
  </xsl:template>
  
  <!--<xsl:template match="tei:text/*">
    <section class="{local-name()}">
      <xsl:apply-templates select="*"/>
    </section>
  </xsl:template>-->
  
  <xsl:template match="tei:div">
    <section>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="*" />
    </section>
  </xsl:template>
  
  <xsl:template match="tei:div" mode="nav">
    <li>
      <xsl:apply-templates select="tei:head" mode="#current" />
      <xsl:if test="tei:div">
        <nav>
          <xsl:apply-templates select="tei:div" mode="#current" />
        </nav>
      </xsl:if>
    </li>
  </xsl:template>
  
  <xsl:template match="tei:head">
    <xsl:variable name="level"
      select="count(ancestor::tei:div)" />
    <xsl:element name="h{$level + 1}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="tei:head" mode="label">
    <p class="label">
      <xsl:apply-templates />
    </p>
  </xsl:template>
  
  <xsl:template match="tei:head" mode="nav">
    <span class="head">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  
  <xsl:template match="tei:p">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>
  
  <xsl:template match="tei:list | tei:listBibl">
    <xsl:apply-templates select="tei:head" mode="label" />
    
    <!--<xsl:variable name="listName">
      <xsl:choose>
        <xsl:when test="@rend eq 'ordered'">ol</xsl:when>
        <xsl:otherwise>ul</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>-->
    
    <xsl:variable name="listName"
      select="if ( @rend eq 'ordered' or self::tei:listBibl ) then 'ol' else 'ul'" />
    
    <xsl:element name="{$listName}">
      <xsl:apply-templates select="tei:item | tei:bibl" />
    </xsl:element>
    
    <!--<xsl:choose>
      <xsl:when test="@rend = 'ordered'">
        <ol>
          <xsl:apply-templates select="tei:item" />
        </ol>
      </xsl:when>
      <xsl:otherwise>
        <ul>
          <xsl:apply-templates select="tei:item" />
        </ul>
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>
  
  <xsl:template match="tei:item | tei:bibl">
    <li>
      <xsl:apply-templates select="@xml:id" />
      <xsl:apply-templates />
    </li>
  </xsl:template>
  
  <xsl:template match="tei:figure">
    <figure id="{@xml:id}">
      <img src="{tei:graphic/@url}" />
      <figcaption>
        <xsl:apply-templates select="tei:head/node()" />
      </figcaption>
    </figure>
  </xsl:template>
  
  <xsl:template match="tei:ref[starts-with(@target, '#')]">
    <a href="{@target}">
      <xsl:apply-templates />
    </a>
  </xsl:template>
  
  <xsl:template match="@xml:id">
    <xsl:attribute name="id" select="." />
  </xsl:template>
  
  <xsl:template match="@type">
    <xsl:attribute name="class" select="." />
  </xsl:template>
</xsl:stylesheet>