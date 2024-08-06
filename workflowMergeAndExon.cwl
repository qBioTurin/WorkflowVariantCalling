#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  csv_directory: Directory
  gtf: File

outputs: 
  exon:
    type: File
    outputSource: exon/exon
  transcript:
    type: File
    outputSource: exon/transcript

steps:
  merge:
    run: cwl/mergeCSV.cwl
    in:
      directory: csv_directory
    out: [mutations]
  exon:
    run: cwl/exon.cwl
    in:
      gtf: gtf
      mutations: merge/mutations
    out: [exon, transcript]
