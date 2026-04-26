//! Security tests for document extractors.
//!
//! These tests verify that security protections are in place and functioning correctly.
//! Each test demonstrates a specific vulnerability and validates that the fix prevents the attack.

#[cfg(test)]
mod latex_security_tests {
    use crate::extractors::latex::LatexExtractor;

    /// Smoke test: unterminated braces must not loop forever or panic.
    #[test]
    fn test_latex_unterminated_braces_protection() {
        let latex = r"\title{";
        let _ = LatexExtractor::extract_from_latex(latex);
    }

    /// Smoke test: deeply nested braces must not stack-overflow.
    #[test]
    fn test_latex_deeply_nested_braces() {
        let mut latex = String::from("\\title{");
        for _ in 0..200 {
            latex.push('{');
        }
        latex.push_str("text");
        for _ in 0..200 {
            latex.push('}');
        }
        latex.push('}');

        let _ = LatexExtractor::extract_from_latex(&latex);
    }

    /// Smoke test: unclosed inline math must not loop forever.
    #[test]
    fn test_latex_unclosed_math_mode() {
        let latex = "This is $inline math without closing";
        let _ = LatexExtractor::extract_from_latex(latex);
    }

    /// Smoke test: unclosed display math must not loop forever.
    #[test]
    fn test_latex_unclosed_display_math() {
        let latex = "Display math: $$x^2 + y^2 without closing";
        let _ = LatexExtractor::extract_from_latex(latex);
    }

    /// Smoke test: a 10 000-character command name must not OOM or panic.
    #[test]
    fn test_latex_long_command_names() {
        let mut latex = String::from("\\");
        for _ in 0..10000 {
            latex.push('a');
        }
        latex.push_str("{content}");

        let _ = LatexExtractor::extract_from_latex(&latex);
    }

    /// Smoke test: many nested environments must not stack-overflow.
    #[test]
    fn test_latex_deeply_nested_environments() {
        let mut latex = String::new();
        for i in 0..50 {
            latex.push_str(&format!("\\begin{{env{i}}}\n"));
        }
        latex.push_str("content");
        for i in (0..50).rev() {
            latex.push_str(&format!("\\end{{env{i}}}\n"));
        }

        let _ = LatexExtractor::extract_from_latex(&latex);
    }

    /// Smoke test: 100 000 list items must not panic or hang.
    #[test]
    fn test_latex_many_list_items() {
        let mut latex = String::from("\\begin{itemize}\n");
        for i in 0..100000 {
            latex.push_str(&format!("\\item Item {i}\n"));
        }
        latex.push_str("\\end{itemize}\n");

        let result = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
            let (text, _, _) = LatexExtractor::extract_from_latex(&latex);
            text.len()
        }));

        assert!(result.is_ok());
    }
}

// Hostile-input coverage for non-LaTeX formats (EPUB, ODT, Jupyter, RST, RTF) lives in the
// integration suite at `crates/kreuzberg/tests/security_validators.rs`, where it can run a real
// extraction through the `SecurityBudget`-guarded code paths and assert on a structured
// `KreuzbergError::Security` outcome.

#[cfg(test)]
mod general_security_tests {
    use crate::extractors::security::*;

    #[test]
    fn test_security_limits_defaults() {
        let limits = SecurityLimits::default();

        assert_eq!(limits.max_archive_size, 500 * 1024 * 1024);
        assert_eq!(limits.max_compression_ratio, 100);
        assert_eq!(limits.max_files_in_archive, 10_000);
        assert_eq!(limits.max_nesting_depth, 1024);
        assert_eq!(limits.max_entity_length, 1024 * 1024);
    }
}
