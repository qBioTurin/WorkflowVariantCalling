#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: qbioturin/mutect2 

baseCommand: ["python3", "/scripts/toTable.py"]

inputs:
  vcf:  
    type: File
    inputBinding:
      position: 1

outputs:
  table_vcf:
    type: File
    outputBinding:
      glob: "mutations_*.csv"
