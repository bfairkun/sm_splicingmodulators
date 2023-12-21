rule Gather_copyFastq:
    input:
        expand("rna-seq/FastqFastp/{sample}.R1.fastq.gz", sample=samples.index.unique()),

rule Gather_alignments:
    input:
        expand("rna-seq/Alignments/STAR_Align/{sample}/Aligned.sortedByCoord.out.bam", sample=samples.index.unique())

rule Gather_featureCounts:
    input:
        expand("rna-seq/featureCounts/GRCh38_GencodeRelease44Comprehensive/{Strandedness}.Counts.txt", Strandedness=samples['Strandedness'].unique())

rule GatherJuncsAndJuncAnnotation:
    input:
        expand("rna-seq/SplicingAnalysis/juncfiles/{sample}.junccounts.tsv.gz", sample=samples.index.unique()),
        "rna-seq/SplicingAnalysis/ObservedJuncsAnnotations/GRCh38_GencodeRelease44Comprehensive.uniq.annotated.tsv.gz"

rule GatherLeafcutterTables:
    input:
        expand("rna-seq/SplicingAnalysis/leafcutter/{GenomeName}/juncTableBeds/{Metric}.sorted.bed.gz", GenomeName="GRCh38_GencodeRelease44Comprehensive", Metric=["PSI", "JuncCounts", "PSI_ByMax"]),
        "rna-seq/SplicingAnalysis/ObservedJuncsAnnotations/{GenomeName}.uniq.annotated.DonorSeq.tsv".format(GenomeName="GRCh38_GencodeRelease44Comprehensive")

rule GatherFastp:
    input:
        expand("rna-seq/FastqFastp/{sample}.R1.fastq.gz", sample=samples.index.unique()),
