require "spec_helper"
require "fileutils"

RSpec.describe Asciidoctor::ITU do
  it "has a version number" do
    expect(Metanorma::ITU::VERSION).not_to be nil
  end

  #it "generates output for the Rice document" do
  #  FileUtils.rm_rf %w(spec/examples/rfc6350.doc spec/examples/rfc6350.html spec/examples/rfc6350.pdf)
  #  FileUtils.cd "spec/examples"
  #  Asciidoctor.convert_file "rfc6350.adoc", {:attributes=>{"backend"=>"itu"}, :safe=>0, :header_footer=>true, :requires=>["metanorma-itu"], :failure_level=>4, :mkdirs=>true, :to_file=>nil}
  #  FileUtils.cd "../.."
  #  expect(File.exist?("spec/examples/rfc6350.doc")).to be true
  #  expect(File.exist?("spec/examples/rfc6350.html")).to be true
  #  expect(File.exist?("spec/examples/rfc6350.pdf")).to be true
  #end

  it "processes a blank document" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
    #{ASCIIDOC_BLANK_HDR}
    INPUT
    #{BLANK_HDR}
<preface/><sections/>
</itu-standard>
    OUTPUT
  end

  it "converts a blank document" do
    FileUtils.rm_f "test.html"
    expect(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
    INPUT
    #{BLANK_HDR}
<preface/><sections/>
</itu-standard>
    OUTPUT
    expect(File.exist?("test.html")).to be true
  end

    it "processes default metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)).to be_equivalent_to <<~'OUTPUT'
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :docnumber: 1000
      :revdate: 2000-01-01
      :copyright-year: 2001
      :title: Main Title
    INPUT
    <itu-standard xmlns="https://open.ribose.com/standards/itu">
<bibdata type="standard">
  <title language="en" format="text/plain" type="main">Main Title</title>
  <docidentifier type="ITU">ITU-T 1000</docidentifier>
  <docnumber>1000</docnumber>
  <contributor>
    <role type="author"/>
    <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
    </organization>
  </contributor>
  <contributor>
    <role type="publisher"/>
    <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
    </organization>
  </contributor>
  <version>
    <revision-date>2000-01-01</revision-date>
  </version>
  <language>en</language>
  <script>Latn</script>
  <status>
    <stage>published</stage>
  </status>
  <copyright>
    <from>2001</from>
    <owner>
      <organization>
        <name>International Telecommunication Union</name>
        <abbreviation>ITU</abbreviation>
      </organization>
    </owner>
  </copyright>
  <ext>
    <doctype>article</doctype>
    <editorialgroup>
      <bureau>T</bureau>
      <group>

      </group>
    </editorialgroup>
    <ip-notice-received>false</ip-notice-received>
  </ext>
</bibdata>
<preface/><sections/>
</itu-standard>
OUTPUT
    end

  it "processes explicit metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)).to be_equivalent_to <<~'OUTPUT'
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :docnumber: 1000
      :provisional-name: ABC
      :doctype: directive
      :edition: 2
      :revdate: 2000-01-01
      :draft: 3.4
      :technical-committee: TC
      :technical-committee-type: provisional
      :copyright-year: 2001
      :status: final-draft
      :iteration: 3
      :language: en
      :title-en: Main Title
      :title-fr: Titre Principal
      :fullname: Fred Flintstone
      :role: author
      :surname_2: Rubble
      :givenname_2: Barney
      :role_2: editor
      :bureau: R
      :bureau_2: T
      :grouptype: A
      :grouptype_2: B
      :groupacronym: C
      :groupacronym_2: D
      :groupyearstart: E
      :groupyearstart_2: F
      :groupyearend: G
      :groupyearend_2: H
      :group: I
      :group_2: J
      :subgrouptype: A1
      :subgrouptype_2: B1
      :subgroupacronym: C1
      :subgroupacronym_2: D1
      :subgroupyearstart: E1
      :subgroupyearstart_2: F1
      :subgroupyearend: G1
      :subgroupyearend_2: H1
      :subgroup: I1
      :subgroup_2: J1
      :workgrouptype: A2
      :workgrouptype_2: B2
      :workgroupacronym: C2
      :workgroupacronym_2: D2
      :workgroupyearstart: E2
      :workgroupyearstart_2: F2
      :workgroupyearend: G2
      :workgroupyearend_2: H2
      :workgroup: I2
      :workgroup_2: J2
      :series: A3
      :series1: B3
      :series2: C3
      :keywords: word1,word2
      :recommendation-from: D3
      :recommendation-to: E3
      :approval-process: F3
      :approval-status: G3

    INPUT
<?xml version="1.0" encoding="UTF-8"?>
<itu-standard xmlns="https://open.ribose.com/standards/itu">
<bibdata type="standard">
  <title language="en" format="text/plain" type="main">Main Title</title>
  <title language="fr" format="text/plain" type="main">Titre Principal</title>
  <docidentifier type="ITU-provisional">ABC</docidentifier>
  <docidentifier type="ITU">ITU-R 1000</docidentifier>
  <docnumber>1000</docnumber>
  <contributor>
    <role type="author"/>
    <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
    </organization>
  </contributor>
  <contributor>
    <role type="publisher"/>
    <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
    </organization>
  </contributor>
  <edition>2</edition>
<version>
  <revision-date>2000-01-01</revision-date>
  <draft>3.4</draft>
</version>  
  <language>en</language>
  <script>Latn</script>
  <status>
    <stage>final-draft</stage>
    <iteration>3</iteration>
  </status>
  <copyright>
    <from>2001</from>
    <owner>
      <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
      </organization>
    </owner>
  </copyright>
  <series type="main">
  <title>A3</title>
</series>
<series type="secondary">
  <title>B3</title>
</series>
<series type="tertiary">
  <title>C3</title>
</series>
  <ext>
  <doctype>directive</doctype>
      <editorialgroup>
      <bureau>R</bureau>
      <group type="A">
        <name>I</name>
        <acronym>C</acronym>
        <period>
          <start>E</start>
          <end>G</end>
        </period>
      </group>
      <subgroup type="A1">
        <name>I1</name>
        <acronym>C1</acronym>
        <period>
          <start>E1</start>
          <end>G1</end>
        </period>
      </subgroup>
      <workgroup type="A2">
        <name>I2</name>
        <acronym>C2</acronym>
        <period>
          <start>E2</start>
          <end>G2</end>
        </period>
      </workgroup>
    </editorialgroup>
    <editorialgroup>
      <bureau>T</bureau>
      <group type="B">
        <name>J</name>
        <acronym>D</acronym>
        <period>
          <start>F</start>
          <end>H</end>
        </period>
      </group>
      <subgroup type="B1">
        <name>J1</name>
        <acronym>D1</acronym>
        <period>
          <start>F1</start>
          <end>H1</end>
        </period>
      </subgroup>
      <workgroup type="B2">
        <name>J2</name>
        <acronym>D2</acronym>
        <period>
          <start>F2</start>
          <end>H2</end>
        </period>
      </workgroup>
    </editorialgroup>
     <keyword>word1</keyword>
 <keyword>word2</keyword>
 <recommendationstatus>
  <from>D3</from>
  <to>E3</to>
  <approvalstage process="F3">G3</approvalstage>
</recommendationstatus>
<ip-notice-received>false</ip-notice-received>
  </ext>
</bibdata>
<preface/><sections/>
</itu-standard>
    OUTPUT
  end

  it "ignores unrecognised status" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :docnumber: 1000
      :doctype: technical-corrigendum
      :secretariat: SECRETARIAT
      :status: pizza
      :iteration: 3
      :language: en
      :title: Main Title
    INPUT
       <?xml version="1.0" encoding="UTF-8"?>
       <itu-standard xmlns="https://open.ribose.com/standards/itu">
       <bibdata type="standard">
         <title language="en" format="text/plain" type="main">Main Title</title>
         <docidentifier type="ITU">ITU-T 1000</docidentifier>
         <docnumber>1000</docnumber>
         <contributor>
           <role type="author"/>
           <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
           </organization>
         </contributor>
         <language>en</language>
         <script>Latn</script>
         <status>
           <stage>pizza</stage>
           <iteration>3</iteration>
         </status>
         <copyright>
           <from>#{Time.now.year}</from>
           <owner>
             <organization>
      <name>International Telecommunication Union</name>
      <abbreviation>ITU</abbreviation>
             </organization>
           </owner>
         </copyright>
         <ext>
         <doctype>technical-corrigendum</doctype>
         <editorialgroup>
  <bureau>T</bureau>
  <group>

  </group>
</editorialgroup>
<ip-notice-received>false</ip-notice-received>
         </ext>
       </bibdata>
       <preface/><sections/>
       </itu-standard>
        OUTPUT
    end

  it "strips inline header" do
    expect(strip_guid(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true))).to be_equivalent_to <<~"OUTPUT"
      #{ASCIIDOC_BLANK_HDR}
      This is a preamble

      == Section 1
      INPUT
    #{BLANK_HDR}
             <preface/><sections><foreword obligation="informative">
         <title>Foreword</title>
         <p id="_">This is a preamble</p>
       </foreword>
       <clause id="_" obligation="normative">
         <title>Section 1</title>
       </clause></sections>
       </itu-standard>
    OUTPUT
  end

  it "uses default fonts" do
    FileUtils.rm_f "test.html"
    Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
    INPUT
    html = File.read("test.html", encoding: "utf-8")
    expect(html).to match(%r[\.Sourcecode[^{]+\{[^}]+font-family: "Space Mono", monospace;]m)
    expect(html).to match(%r[ div[^{]+\{[^}]+font-family: "Open Sans", sans-serif;]m)
    expect(html).to match(%r[h1, h2, h3, h4, h5, h6 \{[^}]+font-family: "Open Sans", sans-serif;]m)
  end

  it "uses default fonts (Word)" do
    FileUtils.rm_f "test.doc"
    Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
    INPUT
    html = File.read("test.doc", encoding: "utf-8")
    expect(html).to match(%r[\.Sourcecode[^{]+\{[^}]+font-family: "Courier New", monospace;]m)
    expect(html).to match(%r[ div[^{]+\{[^}]+font-family: "Times New Roman", serif;]m)
    expect(html).to match(%r[h1 \{[^}]+font-family: "Times New Roman", serif;]m)
  end

  it "uses Chinese fonts" do
    FileUtils.rm_f "test.html"
    Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :script: Hans
    INPUT
    html = File.read("test.html", encoding: "utf-8")
    expect(html).to match(%r[\.Sourcecode[^{]+\{[^}]+font-family: "Space Mono", monospace;]m)
    expect(html).to match(%r[ div[^{]+\{[^}]+font-family: "SimSun", serif;]m)
    expect(html).to match(%r[h1, h2, h3, h4, h5, h6 \{[^}]+font-family: "SimHei", sans-serif;]m)
  end

  it "uses specified fonts" do
    FileUtils.rm_f "test.html"
    Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :script: Hans
      :body-font: Zapf Chancery
      :header-font: Comic Sans
      :monospace-font: Andale Mono
    INPUT
    html = File.read("test.html", encoding: "utf-8")
    expect(html).to match(%r[\.Sourcecode[^{]+\{[^{]+font-family: Andale Mono;]m)
    expect(html).to match(%r[ div,[^{]+\{[^}]+font-family: Zapf Chancery;]m)
    expect(html).to match(%r[h1, h2, h3, h4, h5, h6 \{[^}]+font-family: Comic Sans;]m)
  end

  it "processes inline_quoted formatting" do
    expect(strip_guid(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true))).to be_equivalent_to <<~"OUTPUT"
      #{ASCIIDOC_BLANK_HDR}

      _emphasis_
      *strong*
      `monospace`
      "double quote"
      'single quote'
      super^script^
      sub~script~
      stem:[a_90]
      stem:[<mml:math><mml:msub xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"> <mml:mrow> <mml:mrow> <mml:mi mathvariant="bold-italic">F</mml:mi> </mml:mrow> </mml:mrow> <mml:mrow> <mml:mrow> <mml:mi mathvariant="bold-italic">&#x391;</mml:mi> </mml:mrow> </mml:mrow> </mml:msub> </mml:math>]
      [keyword]#keyword#
      [strike]#strike#
      [smallcap]#smallcap#
    INPUT
    #{BLANK_HDR}
       <preface/><sections>
        <p id="_"><em>emphasis</em>
       <strong>strong</strong>
       <tt>monospace</tt>
       “double quote”
       ‘single quote’
       super<sup>script</sup>
       sub<sub>script</sub>
       <stem type="MathML"><math xmlns="http://www.w3.org/1998/Math/MathML"><msub><mi>a</mi><mn>90</mn></msub></math></stem>
       <stem type="MathML"><math xmlns="http://www.w3.org/1998/Math/MathML"><msub> <mrow> <mrow> <mi mathvariant="bold-italic">F</mi> </mrow> </mrow> <mrow> <mrow> <mi mathvariant="bold-italic">Α</mi> </mrow> </mrow> </msub> </math></stem>
       <keyword>keyword</keyword>
       <strike>strike</strike>
       <smallcap>smallcap</smallcap></p>
       </sections>
       </itu-standard>
    OUTPUT
  end

  it "move sections to preface" do
    FileUtils.rm_f "test.html"
        expect(strip_guid(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true))).to be_equivalent_to <<~"OUTPUT"
      #{ASCIIDOC_BLANK_HDR}
      
      [preface]
      == Prefatory
      section

      == Section

      text
    INPUT
    #{BLANK_HDR}
    <preface><clause id="_" obligation="normative">
  <title>Prefatory</title>
  <p id="_">section</p>
</clause></preface><sections>
<clause id="_" obligation="normative">
  <title>Section</title>
  <p id="_">text</p>
</clause></sections>
</itu-standard>

    OUTPUT
  end

  it "processes sections" do
    expect(strip_guid(Asciidoctor.convert(<<~"INPUT", backend: :itu, header_footer: true)).sub(/^.*<preface/m, "<preface")).to be_equivalent_to <<~"OUTPUT"
      #{ASCIIDOC_BLANK_HDR}
      .Foreword

      Text

      [abstract]
      == Abstract

      Text

      == Introduction

      === Introduction Subsection

      == Scope

      Text

      [bibliography]
      == References

      == Terms and Definitions

      === Term1

      == Terms, Definitions, Symbols and Abbreviated Terms

      [.nonterm]
      === Introduction

      ==== Intro 1

      === Intro 2

      [.nonterm]
      ==== Intro 3

      === Intro 4

      ==== Intro 5

      ===== Term1

      === Normal Terms

      ==== Term2

      ==== Terms defined elsewhere

      === Symbols and Abbreviated Terms

      [.nonterm]
      ==== General

      ==== Symbols 1

      == Abbreviated Terms

      == Clause 4

      === Introduction

      === Clause 4.2

      == Terms and Definitions

      [appendix]
      == Annex

      === Annex A.1

      == Bibliography

      === Bibliography Subsection

      [bibliography]
      == Second Bibliography
    INPUT
    <preface><abstract id="_">
  <p id="_">Text</p>
</abstract></preface><sections><foreword obligation="informative">
  <title>Foreword</title>
  <p id="_">Text</p>
</foreword>

<clause id="_" obligation="normative">
  <title>Introduction</title>
  <clause id="_" obligation="normative">
  <title>Introduction Subsection</title>
</clause>
</clause>
<clause id="_" obligation="normative">
  <title>Scope</title>
  <p id="_">Text</p>
</clause>
<terms id="_" obligation="normative">
  <title>Definitions</title>
  <term id="_">
  <preferred>Term1</preferred>
</term>
</terms>
<clause id="_" obligation="normative"><title>Definitions</title><clause id="_" obligation="normative">
  <title>Introduction</title>
  <clause id="_" obligation="normative">
  <title>Intro 1</title>
</clause>
</clause>
<terms id="_" obligation="normative">
  <title>Intro 2</title>
  <clause id="_" obligation="normative">
  <title>Intro 3</title>
</clause>
</terms>
<clause id="_" obligation="normative">
  <title>Intro 4</title>
  <terms id="_" obligation="normative">
  <title>Intro 5</title>
  <term id="_">
  <preferred>Term1</preferred>
</term>
</terms>
</clause>
<clause id="_" obligation="normative"><title>Normal Terms</title><term id="_">
  <preferred>Term2</preferred>
</term>
<terms id="_" obligation="normative">
  <title>Terms defined elsewhere</title>
</terms></clause>
<definitions id="_"><title>Symbols and Abbreviated Terms</title><clause id="_" obligation="normative">
  <title>General</title>
</clause>
<definitions id="_">
  <title>Symbols 1</title>
</definitions></definitions></clause>
<definitions id="_">
  <title>Abbreviated Terms</title>
</definitions>
<clause id="_" obligation="normative"><title>Clause 4</title><clause id="_" obligation="normative">
  <title>Introduction</title>
</clause>
<clause id="_" obligation="normative">
  <title>Clause 4.2</title>
</clause></clause>
<clause id="_" obligation="normative">
  <title>Terms and Definitions</title>
</clause>

</sections><annex id="_" obligation="normative">
  <title>Annex</title>
  <clause id="_" obligation="normative">
  <title>Annex A.1</title>
</clause>
</annex><bibliography>
<references id="_" obligation="informative">
  <title>References</title>
</references>
<clause id="_" obligation="informative">
  <title>Bibliography</title>
  <references id="_" obligation="informative">
  <title>Bibliography Subsection</title>
</references>
</clause>
<references id="_" obligation="informative">
         <title>Bibliography</title>
       </references>
</bibliography>
</itu-standard>
OUTPUT
  end

end

