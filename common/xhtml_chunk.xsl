<?xml version="1.0"?>
<!--
	This is the XSL customization stylesheet file for the documents
	published on the https://www.inetdoc.net website.

	It took christian.bauer(at)bluemars.de days to figure out this stuff and
	fix most of the obvious bugs in the DocBook XSL distribution, So as the
	present work is based on his stylesheet, credit has to be given back to the
	Hibernate project.

	It also took me days to customize this stylesheet and I have to give some
	credit back to all people who publish XSL customization samples.

	platu(at)inetdoc.net
-->

<!DOCTYPE xsl:stylesheet [
	<!-- The below path is defined by the docbook-xsl-ns Debian package -->
	<!ENTITY db_xsl_path        "/usr/share/xml/docbook/stylesheet/docbook-xsl-ns/">
	<!ENTITY callout_gfx_path   "/images/">
	<!ENTITY admon_gfx_path     "/images/">
	<!ENTITY % w3centities-f PUBLIC "-//W3C//ENTITIES Combined Set//EN//XML"
	"/usr/local/share/w3centities-f.ent">
	%w3centities-f;
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/TR/xhtml1/transitional"
	xmlns:d="http://docbook.org/ns/docbook" exclude-result-prefixes="d">

<xsl:import href="&db_xsl_path;/xhtml-1_1/chunk.xsl"/>
<!-- highlight templates -->
<xsl:import href="&db_xsl_path;/xhtml-1_1/highlight.xsl"/>

<!--###################################################
		Custom Settings
	################################################### -->

	<xsl:param name="l10n.gentext.default.language" select="'fr'"/>

	<xsl:output method="html"
		encoding="utf-8"
		indent="yes"/>

	<!-- <?custom-linebreak?> inserts a line break at this point -->
	<xsl:template match="processing-instruction('custom-linebreak')">
		<br />
	</xsl:template>

	<xsl:param name="chunker.output.encoding" select="'utf-8'" />
	<xsl:param name="chunker.output.indent" select="'yes'" />

	<xsl:param name="generate.legalnotice.link" select="0" />

	<xsl:param name="draft.mode" select="'no'" />

	<xsl:param name="suppress.header.navigation" select="0" />
	<xsl:param name="navig.showtitles" select="0" />

	<xsl:param name="table.borders.with.css" select="0" />
	<xsl:param name="table.frame.border.style" select="'solid'" />
	<xsl:param name="default.table.width">100%</xsl:param>

	<xsl:param name="qanda.inherit.numeration" select="0" />
	<xsl:param name="qanda.defaultlabel">number</xsl:param>
	<xsl:template match="d:question" mode="label.markup">
		<xsl:text>Q</xsl:text>
		<xsl:number level="any" count="d:qandaentry" format="1"/>
	</xsl:template>
	<xsl:param name="qandadiv.autolabel" select="0"/>

    <xsl:template match="question">
      <div class="question">
        <xsl:apply-templates/>
      </div>
    </xsl:template>

    <xsl:template match="answer">
      <div class="answer">
        <xsl:apply-templates/>
      </div>
    </xsl:template>

	<xsl:template match="collabname">
		<xsl:apply-templates/>
	</xsl:template>

<!--###################################################
		HTML Settings
	################################################### -->
	<xsl:param name="highlight.source" select="1" />
	<xsl:param name="highlight.default.language" />

	<xsl:param name="use.id.as.filename" select="1" />
	<xsl:param name="html.stylesheet">inetdoc.css</xsl:param>
	<xsl:param name="css.decoration" select="1" />

	<!-- These extensions are required for table printing and other stuff -->
	<xsl:param name="use.extensions" select="1" />
	<xsl:param name="callouts.extension" select="1" />
	<xsl:param name="textinsert.extension" select="1" />
	<xsl:param name="tablecolumns.extension" select="0" />
	<xsl:param name="callout.extensions" select ="1" />
	<xsl:param name="graphicsize.extension" select="1" />

<!--###################################################
		Table Of Contents
	################################################### -->

	<!-- Generate the TOCs for named components only -->
	<xsl:param name="generate.toc">
		appendix  toc,title
		article/appendix  nop
		article   toc,title
		book      toc,title,figure,table,example,equation
		chapter   nop
		part      nop
		preface   nop
		bibliography  toc
		qandadiv  nop
		qandaset  nop
		reference toc,title
		sect1     nop
		sect2     nop
		sect3     nop
		sect4     nop
		sect5     nop
		section   nop
		set       toc,title
	</xsl:param>

	<!-- Show only Sections up to level 3 in the TOCs -->
	<xsl:param name="toc.section.depth" select="3" />
	<xsl:param name="generate.section.toc.level" select="3" />

	<!-- simplesects are used in bibliographic pages -->
	<xsl:param name="simplesect.in.toc" select="1" />

<!--###################################################
		Labels
	################################################### -->

	<!-- Label Chapters and Sections (numbering) -->
	<xsl:param name="chapter.autolabel" select ="1" />
	<xsl:param name="section.autolabel" select="1" />
	<xsl:param name="section.label.includes.component.label" select="1" />

<!--###################################################
		Callouts
	################################################### -->

	<!-- Use images for callouts instead of (1) (2) (3) -->
	<xsl:param name="callout.graphics" select="1" />
	<xsl:param name="callout.graphics.path">&callout_gfx_path;</xsl:param>
	<xsl:param name="callout.graphics.number.limit" select="15" />
	<xsl:param name="callout.icon.size" select="8" />

	<!-- Place callout marks at this column in annotated areas -->
	<xsl:param name="callout.defaultcolumn">90</xsl:param>

<!--###################################################
		Admonitions
	################################################### -->

	<!-- Use nice graphics for admonitions -->
	<xsl:param name="admon.graphics" select="1" />
	<xsl:param name="admon.graphics.path">&admon_gfx_path;</xsl:param>
	<xsl:param name="admon.graphics.extension" select="'.png'"></xsl:param>
	<xsl:param name="admon.style">
		<xsl:text>margin-left:0;margin-right:1em;</xsl:text>
	</xsl:param>

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

	<!-- Glossary properties -->
	<xsl:param name="glossentry.show.acronym">yes</xsl:param>

  <!-- Variable list properties - add CSS class for styling -->
  <xsl:template match="d:variablelist">
	<div class="variablelist">
		<xsl:call-template name="common.html.attributes"/>
		<xsl:call-template name="id.attribute"/>
		<xsl:call-template name="anchor"/>
		<xsl:if test="d:title|d:info/d:title">
			<xsl:call-template name="formal.object.heading"/>
	</xsl:if>
		<dl>
		<xsl:apply-templates select="d:varlistentry"/>
		</dl>
	</div>
  </xsl:template>

  <!-- Override formalpara to add line break between title and para -->
  <xsl:template match="d:formalpara">
    <div class="formalpara">
      <xsl:call-template name="id.attribute"/>
      <xsl:call-template name="anchor"/>
      <p>
        <strong>
          <xsl:apply-templates select="d:title/node()"/>
        </strong>
      </p>
      <xsl:apply-templates select="d:para"/>
    </div>
  </xsl:template>

</xsl:stylesheet>
