if (file.exists("~/.Rprofile")) source("~/.Rprofile")

# Hugo version must match netlify.toml (HUGO_VERSION = '0.97.0').
# Newer Hugo (>= 0.123) removes getCSV(), which the Wowchemy theme still uses.
options(
  blogdown.hugo.version = "0.97.0",
  blogdown.serve_site.startup = FALSE,
  servr.daemon = TRUE
)

# Num locale nao-UTF-8 (LC_CTYPE=C), format() e knitr::kable() escapam
# acentos como <U+00E7>, corrompendo a tabela do calendario no HTML.
# Garante um locale UTF-8, tentando as variantes mais provaveis.
local({
  if (!isTRUE(l10n_info()[["UTF-8"]])) {
    for (loc in c("pt_BR.UTF-8", "en_US.UTF-8", "C.UTF-8")) {
      if (suppressWarnings(Sys.setlocale("LC_CTYPE", loc)) != "") break
    }
  }
  if (!isTRUE(l10n_info()[["UTF-8"]])) {
    warning("Locale nao-UTF-8: acentos podem sair como <U+XXXX> nas tabelas.",
            call. = FALSE)
  }
})

# Fora do RStudio nao ha pandoc no PATH; reaproveita o que vem com o
# rstudio-server para que o knit dos .Rmd funcione no VS Code.
local({
  p <- "/usr/lib/rstudio-server/bin/quarto/bin/tools/x86_64"
  if (Sys.getenv("RSTUDIO_PANDOC") == "" &&
      file.exists(file.path(p, "pandoc"))) {
    Sys.setenv(RSTUDIO_PANDOC = p)
  }
})
