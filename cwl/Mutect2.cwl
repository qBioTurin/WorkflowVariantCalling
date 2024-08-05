#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  sam_input: File
  genome:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
      - ^.dict
  threads: int

outputs:
  filtered:
    type: File
    outputSource: filter_mutect2/filtered_vcf
  table_vcf: 
    type: File
    outputSource: to_table/table_vcf

steps:
  pre_mutect2:
    run: Mutect2/PreMutect2.cwl
    in:
      sam_input: sam_input
      threads: threads
    out: [bam_indexed]
  mutect2:
    run: Mutect2/mutect2.cwl
    in:
      bam_index: pre_mutect2/bam_indexed
      genome: genome
      threads: threads
    out: [mutect_vcf]
  filter_mutect2:
    run: Mutect2/filterMutect2.cwl
    in:
      vcf: mutect2/mutect_vcf
      genome: genome
    out: [filtered_vcf]
  to_table:
    run: Mutect2/toTable.cwl
    in:
      vcf: filter_mutect2/filtered_vcf
    out: [table_vcf]
