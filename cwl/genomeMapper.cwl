
#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool


requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.index) ]
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: qbioturin/genomemapper:0.4



baseCommand: ["bash", "/scripts/mapping.sh"]

inputs: 
  read_1:
    type: File
    inputBinding:
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2
  index:
    doc: "Index used as reference"
    type: File
    inputBinding: 
      position: 3 
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 4

outputs:
  sam:
    type: File
    outputBinding:
      glob: "*.sam"
