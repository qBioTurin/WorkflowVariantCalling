cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: qbioturin/mutect2

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: broadinstitute/gatk

baseCommand: ["samtools", "view", "-b"]
arguments: 
  - valueFrom: "-o"
    position: 1
  - valueFrom: "file_add.bam"
    position: 2
  - valueFrom: "-F"
    position: 3
  - valueFrom: "4"
    position: 4

inputs:
  sam_add:
    type: File
    inputBinding:
      position: 90 
  threads: 
    type: int?
    default: 2
    inputBinding:
      position: 50
      prefix: '-@'
     
outputs:
  bam_output:
    type: File
    outputBinding:
      glob: file_add.bam
      outputEval: ${
        self[0].basename = inputs.sam_add[0].nameroot + ".bam";
        return self; }
