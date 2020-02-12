<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
   Purpose:
     Print content of a 'xml-stylesheet' processing instruction in root node
     
   Parameters:
     * terminate.on.error (0=no, 1=yes)
       Should the stylesheet terminate with error exit code !=0 when the
       processing instruction cannot be found?
       
   Input:
     DocBook 4/Novdoc document
     
   Output:
     Text content of the 'xml-stylesheet' processing instruction
     (detects this PI only in the root node!)
   
   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright (C) 2012-2020 SUSE Software Solutions Germany GmbH
   
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/lib/lib.xsl"/>

<xsl:output method="text"/>

<xsl:param name="terminate.on.error" select="0"/>

<xsl:template match="*"/>

<xsl:template match="/">
  <xsl:variable name="pi">
    <xsl:apply-templates select="processing-instruction('xml-stylesheet')"/>
  </xsl:variable>
  
  <xsl:choose>
    <xsl:when test="$terminate.on.error != 0 and $pi = ''">
      <xsl:message terminate="yes">ERROR: Couldn't find PI 'xml-stylesheet'!</xsl:message>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$pi"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="/processing-instruction('xml-stylesheet')[1]">
   <!--<xsl:message> PI: xml-stylesheet <xsl:value-of select="."/>
   </xsl:message>-->
   <xsl:call-template name="pi-attribute">
      <xsl:with-param name="pis" select="self::processing-instruction('xml-stylesheet')"/>
      <xsl:with-param name="attribute">href</xsl:with-param>
   </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
