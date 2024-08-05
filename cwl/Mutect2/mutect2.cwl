#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.genome)]

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: qbioturin/mutect2 

baseCommand: ["gatk", "Mutect2"]
arguments: ["--max-reads-per-alignment-start", "5000", "-O", "$(inputs.bam_index.nameroot)_final_result.vcf.gz"]

inputs:
  bam_index:  
    type: File
    inputBinding:
      position: 3
      prefix: -I
    secondaryFiles:
      - .bai
  genome:
    doc: "genome in use"
    type: File
    inputBinding:
      position: 1
      prefix: -R
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai
      - ^.dict
  threads:
    doc: "Max number of threads in use"
    type: int?
    default: 1
    inputBinding:
      position: 2
      prefix: --native-pair-hmm-threads
 

outputs:
  mutect_vcf:
    type: File
    secondaryFiles:
      - .stats
      - .tbi
    outputBinding:
      glob: "$(inputs.bam_index.nameroot)_final_result.vcf.gz"
