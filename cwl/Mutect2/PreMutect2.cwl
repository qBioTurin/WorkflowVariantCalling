#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  sam_input: File
  threads: int

outputs:
  bam_indexed:
    type: File
    outputSource: index_bam/bam_indexed

steps:
  pre_mutect2:
    run: PreMutect2/addOrReplace.cwl
    in:
      sam_input: sam_input
    out: [sam_add]
  sam_to_bam:
    run: PreMutect2/samToBam.cwl
    in:
      sam_add: pre_mutect2/sam_add
      threads: threads
    out: [bam_output]
  sort_bam:
    run: PreMutect2/sortBam.cwl
    in:
      bam_output: sam_to_bam/bam_output
      threads: threads
    out: [bam_sorted]
  index_bam:
    run: PreMutect2/indexBam.cwl
    in:
      bam_sorted: sort_bam/bam_sorted
      threads: threads
    out: [bam_indexed]
