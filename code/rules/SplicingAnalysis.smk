rule MergeDonorSeqsAndAnnotations:
    input:
        juncs = "rna-seq/SplicingAnalysis/ObservedJuncsAnnotations/GRCh38_GencodeRelease44Comprehensive.uniq.annotated.tsv.gz",
        DonorSeqs = "rna-seq/SplicingAnalysis/ObservedJuncsAnnotations/GRCh38_GencodeRelease44Comprehensive.uniq.annotated.DonorSeq.tsv"
    output:
        "SplicingAnalysis/AnnotatedJuncs.tsv.gz"
    log:
        "logs/MergeDonorSeqsAndAnnotations.log"
    shell:
        """
        (cat <(paste <(printf "juncname\tDonorSeq") <(zcat rna-seq/SplicingAnalysis/ObservedJuncsAnnotations/GRCh38_GencodeRelease44Comprehensive.uniq.annotated.tsv.gz | head -1)) <(join --nocheck-order -t $'\\t' <(awk -F'\\t' -v OFS='\\t' '{{ split($1, a, "::"); print a[1], $2 }}' {input.DonorSeqs} | sort) <(zcat {input.juncs} | awk -F'\\t' -v OFS='\\t' 'NR>1 {{ $4=$1"_"$2"_"$3"_"$6; print $4, $0  }}' | sort)) | gzip - > {output}) &> {log}
        """
