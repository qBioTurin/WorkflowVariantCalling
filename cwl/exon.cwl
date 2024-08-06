#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: qbioturin/mutect2:0.2.1 

baseCommand: ["python3", "/scripts/exon.py"]

inputs: 
  gtf:
    type: File
    inputBinding:
      position: 1
      prefix: --gtf
  mutations:
    type: File
    inputBinding:
      position: 2
      prefix: --mutations_file

outputs:
  exon:
    type: File
    outputBinding:
      glob: "results_exon.tsv"
  transcript:
    type: File
    outputBinding:
      glob: "results_transcript.tsv"
