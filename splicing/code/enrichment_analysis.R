fisher_test <- function(set, mod, all) {
  totalshared <- length(intersect(all, set))
  modshared <- length(intersect(mod, set))
  nonmodshared <- totalshared - modshared
  modnonshared <- length(mod) - modshared
  nonmodnonshared <- length(all) - length(mod) - nonmodshared
  confmat <- matrix(c(modshared, modnonshared, nonmodshared, nonmodnonshared), ncol=2)
  fisher.test(confmat, alternative="greater")$p.val
}

get_enrich <- function(signif_genes, all_genes, sets) {
    pvals <- unlist(lapply(sets, function(set) {
        fisher_test(set, signif_genes, all=all_genes)
    }))
    return(data.frame(Pval = sort(pvals), 
                      P.adj = qvalue(sort(pvals))$qvalue))
}