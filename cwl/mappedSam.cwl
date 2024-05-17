#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: scontaldo/filtermappedsam

baseCommand: ["samtools", "view"]
arguments:
  - valueFrom: "-h"
    position: 1
  - valueFrom: "-F"
    position: 2
  - valueFrom: "4"
    position: 3
  - valueFrom: "-o"
    position: 4
  - valueFrom: "$(inputs.sampe.nameroot)_mapped.sam"
    position: 5

inputs: 
  sampe:
    type: File
    inputBinding:
      position: 90
  quality:
    type: int?
    inputBinding:
      position: 50 
      prefix: -q
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      prefix: --threads
      position: 51
  genes_position:
    type: File?
    inputBinding:
      prefix: -L
      position: 52

outputs:
  mapped:
    type: File
    outputBinding:
      glob: "*_mapped.sam"
