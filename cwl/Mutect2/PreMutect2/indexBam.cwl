cwlVersion: v1.2
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [ $(inputs.bam_sorted) ]
  DockerRequirement:
    dockerPull: qbioturin/mutect2

hints:
  DockerRequirement:
    dockerPull: broadinstitute/gatk
  ResourceRequirement:
    coresMax: $(inputs.threads)

baseCommand: ["samtools", "index"]
arguments:
  - valueFrom: $(inputs.bam_sorted[0].basename).bai
    position: 5

inputs:
  bam_sorted:
    type: File
    inputBinding:
      position: 1
      prefix: "-b" 
  threads:
    type: int?
    inputBinding:
      position: 2
      prefix: "-@"   

outputs:
  bam_indexed:
    type: File
    outputBinding:
      glob: "*.bam"
    secondaryFiles:
      - .bai
