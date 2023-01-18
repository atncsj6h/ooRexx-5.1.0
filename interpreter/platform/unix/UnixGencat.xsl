<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="text"/>

   <xsl:template match="Messages">
   <xsl:text>
$ * -------------------------------------------------------------------------
$ *
$ * Copyright (c) 1995, 2004 IBM Corporation. All rights reserved.
$ * Copyright (c) 2005-2017 Rexx Language Association. All rights reserved.
$ *
$ * This program and the accompanying materials are made available under
$ * the terms of the Common Public License v1.0 which accompanies this
$ * distribution. A copy is also available at the following address:
$ * https://www.oorexx.org/license.html
$ *
$ * Redistribution and use in source and binary forms, with or
$ * without modification, are permitted provided that the following
$ * conditions are met:
$ *
$ * Redistributions of source code must retain the above copyright
$ * notice, this list of conditions and the following disclaimer.
$ * Redistributions in binary form must reproduce the above copyright
$ * notice, this list of conditions and the following disclaimer in
$ * the documentation and/or other materials provided with the distribution.
$ *
$ * Neither the name of Rexx Language Association nor the names
$ * of its contributors may be used to endorse or promote products
$ * derived from this software without specific prior written permission.
$ *
$ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
$ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
$ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
$ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
$ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
$ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
$ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
$ * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
$ * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
$ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
$ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
$ *
$ * -------------------------------------------------------------------------
$ ******************************************************************************/
$ * REXX  Support                                                              */
$ *                                                                            */
$ * Definition of Rexx error message numbers                                   */
$ *                                                                            */
$ ******************************************************************************/
$ *
$ * ------------------------------------------------------------------------
$ * --    NOTE:   file is generated by build process
$ * --            ==================================================
$ * --            DO NOT CHANGE THIS FILE, ALL CHANGES WILL BE LOST!
$ * --            ==================================================
$ * ------------------------------------------------------------------------
$ *
$set 1 #REX
</xsl:text>
   <xsl:for-each select="Message | Message/Subcodes/SubMessage">
       <xsl:sort select="MessageNumber" data-type="number"/>

$ <xsl:value-of select="SymbolicName"/> <xsl:text>
</xsl:text>
<xsl:value-of select="MessageNumber"/> <xsl:text> </xsl:text> <xsl:apply-templates select="Text"/>
   </xsl:for-each>
   <xsl:text>


$ * -------------------------------------------------------------------------- */
$ * --            ==================================================        -- */
$ * --            DO NOT CHANGE THIS FILE, ALL CHANGES WILL BE LOST!        -- */
$ * --            ==================================================        -- */
$ * -------------------------------------------------------------------------- */
</xsl:text>
   </xsl:template>

   <xsl:template match="Text">
       <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="q">
       <xsl:text>&quot;</xsl:text><xsl:apply-templates/><xsl:text>&quot;</xsl:text>
   </xsl:template>

   <xsl:template match="sq">
       <xsl:text>&apos;</xsl:text>
   </xsl:template>

   <xsl:template match="dq">
       <xsl:text>&quot;</xsl:text>
   </xsl:template>

   <xsl:template match="Sub">
       <xsl:text>&amp;</xsl:text><xsl:value-of select="@position"/>
   </xsl:template>
</xsl:stylesheet>