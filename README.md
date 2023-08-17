# multiple-configuration-parameterization
Collection of scripts to generate parameter files for use in amber or namd, applying a multi-configurational resp generation approach.

## Dependencies

This project relies on Gaussian 16 for certain calculations. Please ensure that you have the appropriate license and comply with all applicable restrictions and conditions. Minor changes to the code would make it work with other software.

### Gaussian
- **Website**: [https://gaussian.com/]
- **Citation**: Gaussian 16, Revision C.01, M. J. Frisch, G. W. Trucks, H. B. Schlegel, et al., Gaussian, Inc., Wallingford CT, 2019.
- **Note**: Usage of Gaussian is subject to licensing conditions and restrictions, including limitations on competition with Gaussian, Inc. Please refer to the Gaussian license agreement for full details.

### CREST (Conformer-Rotamer Ensemble Sampling Tool)
- **Version**: 2.11.2
- **Citation**: P. Pracht, F. Bohle, S. Grimme, PCCP, 2020, 22, 7169-7192; S. Grimme, JCTC, 2019, 15, 2847-2862.
- **Note**: CREST is distributed without any warranty. Please refer to the software's license for full details.
- **Website**: [https://crest-lab.github.io/crest-docs/]

### xTB (extended Tight-Binding program)
- **Version**: 6.4.1
- **Citation**: Various citations depending on the method used, including:
  - GFN2-xTB: C. Bannwarth, S. Ehlert, S. Grimme, JCTC, 2019, 15, 1652-1671. DOI: 10.1021/acs.jctc.8b01176
  - GFN1-xTB: S. Grimme, C. Bannwarth, P. Shushkov, JCTC, 2017, 13, 1989-2009. DOI: 10.1021/acs.jctc.7b00118
- **License**: GNU Lesser General Public License, version 3 or later.
- **Website**: [https://xtb-docs.readthedocs.io/en/latest/]
