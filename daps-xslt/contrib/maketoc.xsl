<?xml version="1.0"?>
<!--
   Purpose:
     Create toc level structure containing titles only
     
   Parameters:
     None
       
   Input:
     DocBook 4/Novdoc document
     
   Output:
     DocBook XML toc structure, see http://www.docbook.org/tdg/en/html/toc.html
   
   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright (C) 2012-2020 SUSE Software Solutions Germany GmbH
   
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" encoding="UTF-8"/>


<xsl:template match="*" mode="toc"/>


<xsl:template match="/">
  <toc>
    <xsl:apply-templates select="/" mode="toc"/>
  </toc>
</xsl:template>


<xsl:template match="text()" mode="toc"/>


<!-- ==================================================================== -->
<xsl:template match="set|book|article" mode="toc">
   <xsl:apply-templates mode="toc"/>
</xsl:template>


<xsl:template match="refentry" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <xsl:call-template name="subtoc">
    <xsl:with-param name="toc-context" select="$toc-context"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="preface" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <tocfront>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </tocfront>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="chapter|appendix|glossary" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <tocchap>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </tocchap>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="glossentry" mode="toc">
   <tocentry>
    <xsl:if test="@id">
       <xsl:attribute name="linkend"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:value-of select="normalize-space(glossterm)"/>
   </tocentry>
   <xsl:apply-templates mode="toc"/>
</xsl:template>

<xsl:template match="part" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <tocpart>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </tocpart>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>


<xsl:template match="sect1" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <toclevel1>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </toclevel1>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="sect2" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <toclevel2>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </toclevel2>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="sect3" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <toclevel3>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </toclevel3>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="sect4" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <toclevel4>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </toclevel4>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>


<xsl:template match="sect5" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <toclevel5>
   <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
   </xsl:call-template>
  </toclevel5>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>


<!-- ==================================================================== -->
<xsl:template name="subtoc">

  <tocentry>
    <xsl:if test="@id">
       <xsl:attribute name="linkend"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:choose>
         <xsl:when test="title">
            <xsl:value-of select="normalize-space(title)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message>*** Element <xsl:value-of select="concat(name(), 'id=&quot;', @id, '&quot;')"
         /> doesn't contain any title!</xsl:message>
         </xsl:otherwise>
    </xsl:choose>
  </tocentry>
  <xsl:text>&#xA;</xsl:text>
  <xsl:apply-templates mode="toc" />
</xsl:template>


</xsl:stylesheet>
