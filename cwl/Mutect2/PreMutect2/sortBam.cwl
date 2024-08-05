cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: qbioturin/mutect2
  
hints:
  DockerRequirement:
    dockerPull: broadinstitute/gatk
  ResourceRequirement:
    coresMax: $(inputs.threads)

baseCommand: ["samtools", "sort"]
arguments: ["-o", "file_add_sort.bam"]


inputs:  
  threads: 
    type: int?
    default: 2
    inputBinding:
      position: 1
      prefix: '-@'
  bam_output:
    type: File
    inputBinding:
      position: 2
     
outputs:
  bam_sorted:
    type: File
    outputBinding:
      glob: "file_add_sort.bam"
      outputEval: ${
        self[0].basename = inputs.bam_output[0].nameroot + "_sort.bam";
        return self; }  
