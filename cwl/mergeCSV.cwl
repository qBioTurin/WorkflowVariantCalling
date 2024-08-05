#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: qbioturin/mutect2 

baseCommand: ["python3", "/scripts/mergeCSV.py"]

inputs: 
  directory:
    type: Directory
    inputBinding:
      position: 1
      prefix: --directory

outputs:
  mutations:
    type: File
    outputBinding:
      glob: "mutations_all.csv"
