#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: qbioturin/mutect2

baseCommand: ["gatk", "AddOrReplaceReadGroups"]
arguments: ["--RGLB", "lib1", "--RGPL", "ILLUMINA", "--RGPU", "unit_$(inputs.sam_input.nameroot)", "--RGSM", "sample_$(inputs.sam_input.nameroot)", "-O", "sam_add.sam"]

inputs:
  sam_input:
    type: File
    inputBinding:
      position: 1
      prefix: -I

outputs:
  sam_add:
    type: File
    outputBinding:
      glob: "sam_add.sam"
      outputEval: ${
        self[0].basename = inputs.sam_input.nameroot + "_add.sam";
        return self; }
