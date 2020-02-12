<?xml version="1.0" encoding="UTF-8"?>
<!--
   Purpose:
     Extracts linkends from xref elements
     
   Parameters:
     None
       
   Input:
     DocBook 4/Novdoc document
     
   Output:
     
   
   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright (C) 2012-2020 SUSE Software Solutions Germany GmbH
   
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/profiling/profile.xsl"/>

<xsl:param name="rootid"/>
<xsl:output method="text"/>

<xsl:template match="text()"/>

<xsl:template match="/">
  <xsl:choose>
    <xsl:when test="$rootid != ''">
      <xsl:apply-templates select="key('id', $rootid)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>  
</xsl:template>
  
<xsl:template match="//xref/@linkend">
  <xsl:value-of select="."/>
  <xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
