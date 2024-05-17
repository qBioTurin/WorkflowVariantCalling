
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
    dockerPull: qbioturin/genomemapper



baseCommand: ["bwa", "mem"]

inputs: 
  read_1:
    type: File
    inputBinding:
      position: 2 
  read_2:
    type: File
    inputBinding:
      position: 3
  index:
    doc: "Index used as reference"
    type: File
    inputBinding: 
      position: 1 
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
      prefix: -t
      position: 4

outputs:
  sam:
    type: File
    outputBinding:
      glob: |
        ${
          var nameroot = inputs.read_1.nameroot;
          if (nameroot.endsWith(".fastq")){
            nameroot = nameroot.replace(".fastq", "");
          }else if (nameroot.endsWith(".fq")){
            nameroot = nameroot.replace(".fq", "");
          }
          if (nameroot.endsWith("_1") || nameroot.endsWith("_2")){
            nameroot = nameroot.slice(0, -2);
          }else if (nameroot.includes("_R1_")){
            nameroot = nameroot.substring(0, nameroot.indexOf("_R1_"))
          }else if (nameroot.includes("_R2_")){
            nameroot = nameroot.substring(0, nameroot.indexOf("_R2_"))
          }
          return nameroot + '.sam';
        }

stdout: |
  ${
    var nameroot = inputs.read_1.nameroot;
    if (nameroot.endsWith(".fastq")){
      nameroot = nameroot.replace(".fastq", "");
    }else if (nameroot.endsWith(".fq")){
      nameroot = nameroot.replace(".fq", "");
    }
    if (nameroot.endsWith("_1") || nameroot.endsWith("_2")){
      nameroot = nameroot.slice(0, -2);
    }else if (nameroot.includes("_R1_")){
      nameroot = nameroot.substring(0, nameroot.indexOf("_R1_"))
    }else if (nameroot.includes("_R2_")){
      nameroot = nameroot.substring(0, nameroot.indexOf("_R2_"))
    }
    return nameroot + '.sam';
  }
