#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.genome)]

hints:
  DockerRequirement:
    dockerPull: qbioturin/mutect2 

baseCommand: ["gatk", "FilterMutectCalls"]
arguments: ["-O", "$(inputs.vcf.nameroot)_filtered.vcf.gz"]

inputs:
  vcf:  
    type: File
    inputBinding:
      position: 1
      prefix: -V
    secondaryFiles:
      - .stats
      - .tbi
  genome:
    doc: "genome in use"
    type: File
    inputBinding:
      position: 2
      prefix: -R
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai
      - ^.dict

outputs:
  filtered_vcf:
    type: File
    outputBinding:
      glob: "$(inputs.vcf.nameroot)_filtered.vcf.gz" 
