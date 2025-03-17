# CLAUDE.md - Configuration for BD1 Course

## Build Commands
- Generate site: `python generer_site.py`
- Serve local site: `mkdocs serve`
- Build site: `mkdocs build`
- Deploy site: `mkdocs gh-deploy`

## SQL Conventions
- Tables: plural, lowercase, no spaces or accents (use underscores)
- Fields: lowercase, no spaces/numbers, no abbreviations
- Foreign keys: follow pattern `table_id`
- No prefixes in names (except when unavoidable)
- Primary keys named `id`
- No reserved words as field names

## File Structure
- `/docs/`: Main content files
- `/docs/notes_de_cours/`: Course notes
- `/docs/images/`: Image assets
- `/template/`: Excel templates for schedule generation
- `.sql` files in `/docs/` for database examples