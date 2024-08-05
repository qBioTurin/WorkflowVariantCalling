#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  fastq_directory: Directory
  threads: int?
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
      - ^.dict

outputs: 
  filtered_vcf:
    type: File[]
    outputSource: mutect2/filtered
  table_vcf_output:
    type: File[]
    outputSource: mutect2/table_vcf

steps:
  zerothstep:
    run: cwl/zerothStepPairedEnd.cwl
    in:
      dir: fastq_directory
    out: [reads_1, reads_2]
  genomemapper:
    run: cwl/genomeMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: zerothstep/reads_1
      read_2: zerothstep/reads_2
      index: index
      threads: threads
    out: [sam] 
  mutect2:
    run: cwl/Mutect2.cwl
    scatter: [sam_input]
    in:
      sam_input: genomemapper/sam
      genome: index
      threads: threads
    out: [filtered, table_vcf]
