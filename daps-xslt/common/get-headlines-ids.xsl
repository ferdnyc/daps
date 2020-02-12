<?xml version="1.0"?>
<!--
   Purpose:
     Overview of document structure with title and ID
     
   Parameters:
     * separator (default: " ")
       Separates the different parts of the output
     * endseparator (default: "&#10;")
       Separator at the end of a line
     * indent (default: "  ")
       Spaces to indent with
      
   Input:
     DocBook document
     
   Output:
     Text output in the form
      ELEMENT: TITLE ID
      
   
   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright (C) 2012-2020 SUSE Software Solutions Germany GmbH
   
-->
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="d">

  <xsl:import href="rootid.xsl"/>

  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:param name="separator" select="' '"/>
  <xsl:param name="endseparator" select="'&#10;'"/>
  <xsl:param name="indent"><xsl:text>  </xsl:text></xsl:param>

  <xsl:template match="text()"/>


 <xsl:template match="d:set|d:article|d:book|d:part|d:chapter|d:appendix|d:preface|d:sect1|d:sect2|d:sect3|d:sect4"
               name="process">
    <xsl:param name="ind" select="''"/>
    <xsl:variable name="titlefound" select="(title|d:title|d:info/d:title)[1]"/>
    <xsl:variable name="title" select="normalize-space($titlefound)"/>
    <xsl:variable name="level" select="count(ancestor-or-self::*)"/>

    <xsl:if test="@xml:base">
      <xsl:call-template name="getbasename"/>
    </xsl:if>

    <xsl:value-of select="$ind"/>
    <xsl:choose>
      <xsl:when test="(@id|@xml:id)[1]">
        <xsl:call-template name="gettitle_id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of
          select="concat(local-name(.), ': ', normalize-space($titlefound), ' (**Missing ID**)', '&#10;')"
        />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates>
      <xsl:with-param name="ind" select="concat($ind, $indent)"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="set|article|book|part|chapter|appendix|preface|sect1|sect2|sect3|sect4">
    <xsl:call-template name="process"/>
  </xsl:template>

  <!-- ****************************************** -->

  <xsl:template name="gettitle_id">
    <xsl:param name="node" select="."/>
    <xsl:variable name="titlefound" select="(title|d:title|d:info/d:title)[1]"/>
    <xsl:variable name="title" select="normalize-space($titlefound)"/>

    <xsl:value-of
      select="concat(local-name(.), ': ', normalize-space($titlefound), ' (', ($node/@id|$node/@xml:id)[1]  ,')', '&#10;')"
    />
  </xsl:template>

  <xsl:template name="getbasename">
    <xsl:param name="node" select="."/>
    <xsl:value-of select="concat('-----', $node/@xml:base, '-----', '&#10;')"/>
  </xsl:template>

</xsl:stylesheet>
