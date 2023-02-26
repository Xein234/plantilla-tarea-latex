from pathlib import Path
from doit.action import CmdAction

build_dir = Path('build')
src_dir   = Path('src')
tex_file = src_dir   / Path('tarea2.tex')
pdf_file = build_dir / tex_file.with_suffix('.pdf').name

def task_build():
    build_dir.mkdir(exist_ok=True)
    action = ['xelatex', f'-output-directory={build_dir}', f'{tex_file}']
    return {'actions': [action],
        'targets': [pdf_file],
        'verbosity':2,
        'file_dep': [tex_file]}
