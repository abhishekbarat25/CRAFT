# =============================================================================
# Company-Specific Resume Generator - Makefile
# =============================================================================

# --- VARIABLES ---
LATEX    = pdflatex
TARGET   = src/main.tex
OUT_DIR  = output

# IMPORTANT: Set your name here (this will be used in the output filename)
# Example: NAME = John_Doe
NAME     = Abhishek_Barat

# Company to generate resume for (from src/companies/ folder)
# Override with: make COMPANY=google
COMPANY  ?= apple

# Paths
COMP_DIR = $(OUT_DIR)/$(COMPANY)
AUX_DIR  = $(COMP_DIR)/internals

# --- COMMANDS ---

all: pdf

pdf:
	mkdir -p $(AUX_DIR)
	# Run 1: Generate files into the internals folder
	$(LATEX) -jobname=$(NAME)_$(COMPANY) \
	-output-directory=$(AUX_DIR) \
	"\def\currcompany{$(COMPANY)}\input{$(TARGET)}"

	# Run 2: Finalize references
	$(LATEX) -jobname=$(NAME)_$(COMPANY) \
	-output-directory=$(AUX_DIR) \
	"\def\currcompany{$(COMPANY)}\input{$(TARGET)}"

	# Copy PDF to the Company folder
	cp $(AUX_DIR)/$(NAME)_$(COMPANY).pdf $(COMP_DIR)/

	@echo "-------------------------------------------------------"
	@echo "PDF GENERATED: $(COMP_DIR)/$(NAME)_$(COMPANY).pdf"
	@echo "-------------------------------------------------------"

# Clean auxiliary files only (keeps PDFs)
clean:
	rm -f *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz src/*.aux
	rm -rf $(OUT_DIR)/*/internals
	@echo "Cleanup complete. Temporary files removed, PDFs preserved."

# Full clean (removes everything including PDFs)
fclean:
	rm -rf $(OUT_DIR)
	@echo "All output folders and PDFs deleted."

# Help target
help:
	@echo "Usage:"
	@echo "  make COMPANY=<company>"
	@echo ""
	@echo "Examples:"
	@echo "  make COMPANY=apple"
	@echo "  make COMPANY=google"
	@echo ""
	@echo "Configuration:"
	@echo "  Set NAME variable in Makefile (line 9) to change output filename"
	@echo "  Company-specific files must be in src/companies/<company>/"
	@echo ""
	@echo "Commands:"
	@echo "  make pdf      - Generate resume (default)"
	@echo "  make clean    - Remove temp files, keep PDFs"
	@echo "  make fclean   - Remove all output"
	@echo "  make help     - Show this help"

.PHONY: all pdf clean fclean help
