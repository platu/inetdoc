<?xml version='1.0'?>

<!--

    This is the XSL FO customization stylesheet file for the documents
    published on the http://www.inetdoc.net website.
    It defines a custom titlepage and parameters for PDF printable output.

    It took christian.bauer(at)bluemars.de days to figure out this stuff and
    fix most of the obvious bugs in the DocBook XSL distribution, So as the
    present work is based on his stylesheet, credit has to be given back to the
    Hibernate project.

    It also took me days to customize this stylesheet and I have to give some
    credit back to all people who publish free XSL-FO customization samples.

    platu(at)inetdoc.net

-->

<!DOCTYPE xsl:stylesheet [
  <!-- The below path is defined by the docbook-xsl-ns Debian package -->
  <!ENTITY db_xsl_path        "/usr/share/xml/docbook/stylesheet/docbook-xsl-ns/">
  <!ENTITY callout_gfx_path   "&db_xsl_path;images/callouts/">
  <!ENTITY admon_gfx_path     "&db_xsl_path;images/">
]>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook" exclude-result-prefixes="d">
                
<xsl:import href="&db_xsl_path;/fo/docbook.xsl"/>

<!--###################################################
                   Custom Settings
    ################################################### --> 

    <xsl:param name="draft.mode" select="'no'" />
    <!-- Alignement du texte a gauche
    <xsl:param name="alignment">start</xsl:param>-->
    <xsl:param name="hyphenate">false</xsl:param>
    <xsl:param name="ulink.footnotes" select="1" />

    <!-- <?custom-pagebreak?> inserts a page break at this point -->

    <xsl:template match="processing-instruction('custom-pagebreak')">
      <fo:block break-before='page'/>
    </xsl:template>

    <xsl:attribute-set name="xref.properties">
      <xsl:attribute name="color">#af0228</xsl:attribute>
    </xsl:attribute-set>

    <xsl:param name="qanda.inherit.numeration" select="0" />

    <!-- automated index generation -->
    <xsl:param name="generate.index" select="1"/>
    <xsl:param name="make.index.markup" select="0"/>

    <!-- images rendering tests -->
    <xsl:param name="use.svg" select="1"/>
    <xsl:param name="use.role.for.mediaobject" select="1"/>

<!--###################################################
                   Fonts & Styles
    ################################################### -->      

    <xsl:param name="title.font.family">DejaVuSans</xsl:param>
    <xsl:param name="body.font.family">DejaVuSerif</xsl:param>
    <xsl:param name="monospace.font.family">DejaVuSansMono</xsl:param>
    <xsl:param name="symbol.font.family">DejaVuSansMono</xsl:param>

    <!-- Default Font size -->
    <xsl:param name="body.font.master">9</xsl:param>

    <!-- Line height in body text -->
    <xsl:param name="line-height">1.15</xsl:param>

    <!-- Monospaced fonts are smaller than regular text -->
    <xsl:attribute-set name="monospace.properties">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
          <xsl:value-of select="$body.font.master * 0.8"/>
          <xsl:text>pt</xsl:text>
	</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="normal.para.spacing">
      <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
      <xsl:attribute name="space-before.minimum">0.3em</xsl:attribute>
      <xsl:attribute name="space-before.maximum">0.7em</xsl:attribute>
    </xsl:attribute-set>

<!--###################################################
                   Custom Article Title Page
    ################################################### --> 
    
    <xsl:template name="article.titlepage.recto">
      <fo:block>
        <fo:block background-color="#333" padding="3pt">
	  <fo:block color="#fff" text-align="right"
		    font-family="DejaVuSans-Bold" font-size="18pt"
                    margin-right="10mm">
            <xsl:value-of select="d:title|d:info/d:title" />
          </fo:block>

          <xsl:for-each select="d:info/*/d:author">
	    <fo:block color="#eee" text-align="right"
	              font-family="DejaVuSans-Bold" font-size="10pt"
                      margin-right="10mm">
              <xsl:value-of select="d:personname/d:firstname"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="d:personname/d:surname"/>
            </fo:block>
	    <fo:block color="#ddd" text-align="right"
		      font-family="DejaVuSans" font-size="9pt"
                      margin-right="10mm">
              <xsl:value-of select="d:affiliation/d:address/d:email"/> 
            </fo:block>
          </xsl:for-each>

          <xsl:choose>
            <xsl:when test="d:info/*/d:editor|d:info/d:editor">
              <fo:block color="#ddd" text-align="right" 
                        font-style="italic" margin-right="50mm">
                <xsl:text>Publié par :</xsl:text>
              </fo:block>
            </xsl:when>
          </xsl:choose>

          <xsl:for-each select="d:info/*/d:editor">
	    <fo:block color="#eee" text-align="right"
	              font-family="DejaVuSans-Bold" font-size="10pt"
                      margin-right="10mm">
              <xsl:value-of select="d:personname/d:firstname"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="d:personname/d:surname"/>
            </fo:block>
	    <fo:block color="#ddd" text-align="right"
		      font-family="DejaVuSans" font-size="9pt"
                      margin-right="10mm">
              <xsl:value-of select="d:affiliation/d:address/d:email"/> 
            </fo:block>
          </xsl:for-each>
        </fo:block>

	<fo:block color="#fff" background-color="#af0228" text-align="left"
                  font-size="9pt" font-weight="bold" font-style="italic" padding="3pt">
          <xsl:text>http://www.inetdoc.net</xsl:text>
        </fo:block>

        <xsl:choose>
          <xsl:when test="*/d:abstract">
            <fo:block color="#333" text-align="left"
		      font-family="DejaVuSans" font-weight="bold" padding="3pt"
                      margin-top="6pt">
              <xsl:value-of select="d:info/d:abstract"/> 
            </fo:block>
          </xsl:when>
        </xsl:choose>
      </fo:block>
    </xsl:template>

<!--###################################################
                   Custom Book Title Page
    ################################################### --> 

    <xsl:template name="book.titlepage.recto">
      <fo:block>
        <fo:block background-color="#333" padding="3pt">
	  <fo:block color="#fff" text-align="right"
		    font-family="DejaVuSans-Bold" font-size="18pt"
                    margin-right="10mm" margin-bottom="5pt">
            <xsl:value-of select="d:title|d:info/d:title" />
          </fo:block>

          <xsl:for-each select="//d:author">
	    <fo:block color="#eee" text-align="right"
	              font-family="DejaVuSans-Bold" font-size="10pt"
                      margin-right="10mm">
              <xsl:value-of select="d:personname/d:firstname"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="d:personname/d:surname"/>
            </fo:block>
	    <fo:block color="#ddd" text-align="right"
		      font-family="DejaVuSans" font-size="9pt"
                      margin-right="10mm">
              <xsl:value-of select="d:affiliation/d:address/d:email"/> 
            </fo:block>
          </xsl:for-each>

          <xsl:choose>
            <xsl:when test="//d:editor">
              <fo:block color="#ddd" text-align="right" 
                        font-style="italic" margin-right="50mm">
                <xsl:text>Publié par :</xsl:text>
              </fo:block>
            </xsl:when>
          </xsl:choose>

          <xsl:for-each select="//d:editor">
	    <fo:block color="#eee" text-align="right"
	              font-family="DejaVuSans-Bold" font-size="10pt"
                      margin-right="10mm">
              <xsl:value-of select="d:personname/d:firstname"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="d:personname/d:surname"/>
            </fo:block>
	    <fo:block color="#ddd" text-align="right"
		      font-family="DejaVuSans" font-size="9pt"
                      margin-right="10mm">
              <xsl:value-of select="d:affiliation/d:address/d:email"/> 
            </fo:block>
          </xsl:for-each>
        </fo:block>

	<fo:block color="#fff" background-color="#af0228" text-align="left"
                  font-size="9pt" font-weight="bold" font-style="italic" padding="3pt">
          <xsl:text>http://www.inetdoc.net</xsl:text>
        </fo:block>

        <xsl:choose>
          <xsl:when test="*/d:abstract">
            <fo:block color="#333" text-align="left"
		      font-family="DejaVuSans" font-weight="bold" padding="3pt"
                      margin-top="6pt">
              <xsl:value-of select="d:info/d:abstract"/> 
            </fo:block>
          </xsl:when>
        </xsl:choose>
      </fo:block>
    </xsl:template>

    <!-- Prevent blank pages in output -->    
    <xsl:template name="book.titlepage.before.verso">
    </xsl:template>
    <xsl:template name="book.titlepage.verso">
    </xsl:template>
    <xsl:template name="book.titlepage.separator">
    </xsl:template>
        
<!--###################################################
                      Header
    ################################################### -->  

    <!-- More space in the center header for long text -->
    <xsl:attribute-set name="header.content.properties">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$body.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">-5em</xsl:attribute>
        <xsl:attribute name="margin-right">-5em</xsl:attribute>
    </xsl:attribute-set>

<!--###################################################
                      Custom Footer
    ################################################### -->     

    <!-- This footer prints the Title on the left side -->
    <xsl:template name="footer.content">
        <xsl:param name="pageclass" select="''"/>
        <xsl:param name="sequence" select="''"/>
        <xsl:param name="position" select="''"/>
        <xsl:param name="gentext-key" select="''"/>

        <fo:block font-size="8pt">
        <xsl:variable name="Title">
          <xsl:value-of select="//d:title"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$sequence='blank'">
            <xsl:choose>
                <xsl:when test="$double.sided != 0 and $position = 'left'">
                <xsl:value-of select="$Title"/>
                </xsl:when>

                <xsl:when test="$double.sided = 0 and $position = 'center'">
                <!-- nop -->
                </xsl:when>

                <xsl:otherwise>
                <fo:page-number/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>

            <xsl:when test="$pageclass='titlepage'">
            <!-- nop: other titlepage sequences have no footer -->
            </xsl:when>

            <xsl:when test="$double.sided != 0 and $sequence = 'even' and $position='left'">
            <fo:page-number/>
            </xsl:when>

            <xsl:when test="$double.sided != 0 and $sequence = 'odd' and $position='right'">
            <fo:page-number/>
            </xsl:when>

            <xsl:when test="$double.sided = 0 and $position='right'">
            <fo:page-number/>
            </xsl:when>

            <xsl:when test="$double.sided != 0 and $sequence = 'odd' and $position='left'">
            <xsl:value-of select="$Title"/>
            </xsl:when>

            <xsl:when test="$double.sided != 0 and $sequence = 'even' and $position='right'">
            <xsl:value-of select="$Title"/>
            </xsl:when>

            <xsl:when test="$double.sided = 0 and $position='left'">
            <xsl:value-of select="$Title"/>
            </xsl:when>

            <xsl:otherwise>
            <!-- nop -->
            </xsl:otherwise>
        </xsl:choose>
        </fo:block>
    </xsl:template>
    
<!--###################################################
                      Extensions
    ################################################### -->  

    <!-- These extensions are required for table printing and other stuff -->
    <xsl:param name="use.extensions" select="1" />
    <xsl:param name="tablecolumns.extension" select="0" />
    <xsl:param name="callout.extensions" select="1" />
    <!-- FOP provide only PDF Bookmarks at the moment -->
    <xsl:param name="fop1.extensions" select="1" />

<!--###################################################
                      Table Of Contents
    ################################################### -->   

    <!-- Generate the TOCs for named components only -->
    <xsl:param name="generate.toc">
    /appendix toc,title
    article/appendix  nop
    article   toc,title
    book      toc,title,figure,table,example,equation
    /chapter  nop
    part      toc,title
    /preface  toc,title
    qandadiv  toc
    qandaset  nop
    reference toc,title
    /sect1    toc
    /sect2    toc
    /sect3    toc
    /sect4    toc
    /sect5    toc
    /section  toc
    set       toc,title
    </xsl:param>
    
    <!-- Show only Sections up to level 3 in the TOCs -->
    <xsl:param name="toc.section.depth">3</xsl:param>
    <xsl:param name="generate.section.toc.level" select="3" />
    
    <!-- Dot and Whitespace as separator in TOC between Label and Title-->
    <xsl:param name="autotoc.label.separator" select="'.  '"/>

    <!-- simplesects are used in bibliographic pages -->
    <xsl:param name="simplesect.in.toc" select="1" />

<!--###################################################
                   Paper & Page Size
    ################################################### -->  
    
    <!-- Paper type, no headers on blank pages, no double sided printing -->
    <xsl:param name="paper.type" select="'A4'"/>
    <xsl:param name="double.sided">0</xsl:param>
    <xsl:param name="headers.on.blank.pages">0</xsl:param>
    <xsl:param name="footers.on.blank.pages">0</xsl:param>
    <xsl:param name="footer.column.widths">3 0.1 1</xsl:param>

    <!-- Space between paper border and content (chaotic stuff, don't touch) -->
    <xsl:param name="page.margin.top">5mm</xsl:param>
    <xsl:param name="region.before.extent">10mm</xsl:param>
    <xsl:param name="body.margin.top">10mm</xsl:param>
    
    <xsl:param name="body.margin.bottom">15mm</xsl:param>
    <xsl:param name="region.after.extent">10mm</xsl:param>
    <xsl:param name="page.margin.bottom">5mm</xsl:param>
    
    <xsl:param name="page.margin.outer">18mm</xsl:param>
    <xsl:param name="page.margin.inner">18mm</xsl:param>

    <!-- No indentation of Titles -->
    <xsl:param name="title.margin.left">0pt</xsl:param>

    <!-- No intendation of body text since DocBook 1.68.1 -->
    <xsl:param name="body.start.indent">0pt</xsl:param>

    
<!--###################################################
                   Tables
    ################################################### -->

    <!-- Page breaks are allowed within tables -->
    <xsl:attribute-set name="formal.object.properties">
      <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.properties"
      use-attribute-sets="formal.object.properties" />

    <!-- The table width should be adapted to the paper size -->
    <xsl:param name="default.table.width">17.5cm</xsl:param>

    <!-- Some padding inside tables -->    
    <xsl:attribute-set name="table.cell.padding">
        <xsl:attribute name="padding-left">4pt</xsl:attribute>
        <xsl:attribute name="padding-right">4pt</xsl:attribute>
        <xsl:attribute name="padding-top">4pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Only hairlines as frame and cell borders in tables -->
    <xsl:param name="table.frame.border.thickness">1pt</xsl:param>
    <xsl:param name="table.cell.border.thickness">1pt</xsl:param>
        
<!--###################################################
                         Labels
    ################################################### -->   

    <!-- Label Chapters and Sections (numbering) -->
    <xsl:param name="chapter.autolabel" select="1" />
    <xsl:param name="section.autolabel" select="1" />
    <xsl:param name="section.label.includes.component.label" select="1"/>

<!--###################################################
                         Titles
    ################################################### -->   
    
    <!-- Chapter title size -->
    <xsl:attribute-set name="chapter.titlepage.recto.style">
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.25"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>        
    </xsl:attribute-set>

    <!-- Why is the font-size for chapters hardcoded in the XSL FO templates? 
        Let's remove it, so this sucker can use our attribute-set only... -->
    <xsl:template match="d:title" mode="chapter.titlepage.recto.auto.mode">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
                  xsl:use-attribute-sets="chapter.titlepage.recto.style">
            <xsl:call-template name="component.title">
                <xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
            </xsl:call-template>
            </fo:block>
    </xsl:template>
    
    <!-- Unnumbered sections titles have a waste of space after -->    
    <xsl:attribute-set name="section.title.properties">
        <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.3em</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.25"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>

    <!-- Sections 1, 2 and 3 titles have a small bump factor and padding -->    
    <xsl:attribute-set name="section.title.level1.properties">
        <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.6em</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.25"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.3em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level2.properties">
        <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.6em</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.15"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.3em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level3.properties">
        <xsl:attribute name="space-before.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.3em</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.10"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.3em</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Bibliography title size -->
    <xsl:template name="bibliography.titlepage.recto">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xsl:use-attribute-sets="bibliography.titlepage.recto.style"
		margin-left="{$title.margin.left}"
		font-size="{$body.font.master * 1.25}pt"
		font-family="{$title.fontset}"
		font-weight="bold">
        <xsl:call-template name="component.title">
          <xsl:with-param name="node" select="ancestor-or-self::bibliography[1]"/>
        </xsl:call-template>
      </fo:block>
      <xsl:choose>
        <xsl:when test="bibliographyinfo/subtitle">
          <xsl:apply-templates mode="bibliography.titlepage.recto.auto.mode" select="bibliographyinfo/subtitle"/>
        </xsl:when>
        <xsl:when test="docinfo/subtitle">
          <xsl:apply-templates mode="bibliography.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
        </xsl:when>
        <xsl:when test="subtitle">
          <xsl:apply-templates mode="bibliography.titlepage.recto.auto.mode" select="subtitle"/>
        </xsl:when>
        <xsl:when test="bibliodiv/title">
          <xsl:apply-templates mode="bibliography.titlepage.recto.auto.mode" select="bibliodiv/title"/>
        </xsl:when>
      </xsl:choose>
    </xsl:template>

    <xsl:template match="d:title" mode="bibliodiv.titlepage.recto.auto.mode">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xsl:use-attribute-sets="bibliodiv.titlepage.recto.style"
		margin-left="{$title.margin.left}"
		font-size="{$body.font.master * 1.0}pt"
		font-family="{$title.fontset}"
		font-weight="bold">
        <xsl:call-template name="component.title">
          <xsl:with-param name="node" select="ancestor-or-self::bibliodiv[1]"/>
        </xsl:call-template>
      </fo:block>
    </xsl:template>

    <!-- Titles of formal objects (tables, examples, ...) -->
    <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
      <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
      <xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
      <xsl:attribute name="space-before.maximum">0.6em</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="font-size">
        <xsl:value-of select="$body.font.master"/>
          <xsl:text>pt</xsl:text>
        </xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="space-after.minimum">0.2em</xsl:attribute>
      <xsl:attribute name="space-after.optimum">0.4em</xsl:attribute>
      <xsl:attribute name="space-after.maximum">0.6em</xsl:attribute>
    </xsl:attribute-set>    

    <!-- Formal objects (tables, examples, ...) -->
    <xsl:attribute-set name="formal.object.properties">
      <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
      <xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
      <xsl:attribute name="space-before.maximum">0.8em</xsl:attribute>
      <xsl:attribute name="space-after.minimum">0.2em</xsl:attribute>
      <xsl:attribute name="space-after.optimum">0.4em</xsl:attribute>
      <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
      <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <!-- Override formalpara title from inline to block -->
    <xsl:template match="d:formalpara/d:title">
      <xsl:variable name="titleStr">
        <xsl:apply-templates/>
      </xsl:variable>
      <xsl:variable name="lastChar">
        <xsl:if test="$titleStr != ''">
          <xsl:value-of select="substring($titleStr,string-length($titleStr),1)"/>
        </xsl:if>
      </xsl:variable>

      <fo:block font-weight="bold"
                keep-with-next.within-line="always"
                padding-end="1em">
        <xsl:copy-of select="$titleStr"/>
        <xsl:if test="$lastChar != ''
                     and not(contains($runinhead.title.end.punct, $lastChar))">
          <xsl:value-of select="$runinhead.default.title.end.punct"/>
        </xsl:if>
      </fo:block>
    </xsl:template>

<!--###################################################
                      Programlistings
    ################################################### -->  
    
    <!-- Verbatim text formatting (programlistings) --> 
    <xsl:attribute-set name="verbatim.properties">
        <xsl:attribute name="font-family">
          <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.3em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.4em</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.3em</xsl:attribute>
        <xsl:attribute name="border-color">#333</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>      
        <xsl:attribute name="padding">0.25em</xsl:attribute>      
    </xsl:attribute-set>

    <!-- Shade (background) programlistings -->    
    <xsl:param name="shade.verbatim" select="1" />
    <xsl:attribute-set name="shade.verbatim.style">
        <xsl:attribute name="background-color">#eee</xsl:attribute>
    </xsl:attribute-set>

<!--###################################################
                         Callouts
    ################################################### -->   

    <!-- Use images for callouts instead of (1) (2) (3) -->
    <xsl:param name="callout.graphics" select="1" />
    <xsl:param name="callout.graphics.path">&callout_gfx_path;</xsl:param>
    <xsl:param name="callout.graphics.number.limit" select="15" />
    <xsl:param name="callout.unicode" select="1" />
    
    <!-- Place callout marks at this column in annotated areas -->
    <xsl:param name="callout.defaultcolumn">90</xsl:param>

<!--###################################################
                       Admonitions
    ################################################### -->   

    <!-- Use nice graphics for admonitions -->
    <xsl:param name="admon.graphics" select="1" />
    <xsl:param name="admon.graphics.path">&admon_gfx_path;</xsl:param>

    <xsl:template match="*" mode="admon.graphic.width">
      <xsl:text>12pt</xsl:text>
    </xsl:template>

    <xsl:attribute-set name="admonition.title.properties">
      <xsl:attribute name="font-size">
        <xsl:value-of select="$body.font.master*0.9"/>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="graphical.admonition">
      <xsl:variable name="id">
        <xsl:call-template name="object.id"/>
      </xsl:variable>
      <xsl:variable name="graphic.width">
        <xsl:apply-templates select="." mode="admon.graphic.width"/>
      </xsl:variable>

      <fo:block space-before.minimum="0.8em"
                space-before.optimum="1em"
                space-before.maximum="1.2em"
                start-indent="0.25in"
                border-top="0.5pt solid black"
                border-bottom="0.5pt solid black"
                padding-top="4pt"
                padding-bottom="4pt"
                id="{$id}">

        <fo:list-block provisional-distance-between-starts="{$graphic.width} + 18pt"
                       provisional-label-separation="18pt">
          <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
              <fo:block>
                <fo:external-graphic width="auto" height="auto"
                                     content-width="{$graphic.width}" >
                  <xsl:attribute name="src">
                    <xsl:call-template name="admon.graphic"/>
                  </xsl:attribute>
                </fo:external-graphic>
              </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
              <xsl:if test="$admon.textlabel != 0 or title">
                <fo:block xsl:use-attribute-sets="admonition.title.properties">
                  <xsl:apply-templates select="." mode="object.title.markup"/>
                </fo:block>
              </xsl:if>
              <fo:block xsl:use-attribute-sets="admonition.properties">
                <xsl:apply-templates/>
              </fo:block>
            </fo:list-item-body>
          </fo:list-item>
        </fo:list-block>
      </fo:block>
    </xsl:template>

<!--###################################################
                          Lists
    ################################################### -->   

    <!-- more space needed for nested inherited arabic numbered orderedlits -->
    <xsl:param name="orderedlist.label.width">2em</xsl:param>

<!--###################################################
                          Misc
    ################################################### -->   

    <!-- Placement of titles -->
    <xsl:param name="formal.title.placement">
        figure after
        example before
        equation before
        table before
        procedure before
    </xsl:param>
    
    <!-- Format Variable Lists as Blocks (prevents horizontal overflow) -->
    <xsl:param name="variablelist.as.blocks" select="1" />

    <!-- Qandas -->
    <xsl:attribute-set name="qanda.title.properties">
      <xsl:attribute name="font-family">
          <xsl:value-of select="$title.font.family"></xsl:value-of>
      </xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
        <!-- font size is calculated dynamically by qanda.heading template -->
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.3em</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
