-- The OUTER UNION operator concatenates the results of the queries

proc sql;
   title 'A OUTER UNION B';
   select * from sql.a
   outer union
   select * from sql.b;

-- To overlay columns in the same position, use the CORRESPONDING keyword.
proc sql;
   title 'A OUTER UNION CORR B';
   select * from sql.a
   outer union corr
   select * from sql.b;

-- find SNPs associated with OMIM gene
select
   concat(left(title1,30),"..."),
   omimId,
   S.name,
   S.func,
   G.chrom,
   S.chromStart,
   S.chromEnd
from
   omimGene as G,
   omimGeneMap as M,
   snp130 as S
where
  G.name=M.omimId and
  G.chrom=S.chrom and
  S.chromStart>=G.chromStart and
  S.chromEnd <= G.chromEnd
limit 10;'

