module {
  name: "flow-matrix",
  description: "Produces a text table from a list of triplet of (sources, dests, attributes) sets",
  repository: {
    type: "git",
    url: "https://github.com/thydel/jq-modules"
  }
};

def index:
  def triplet:
    . as $in
    | $in[0][] as $source | $in[1][] as $dest | $in[2][] as $attr | [ $source, $dest, $attr ];
  def merge:
    reduce .[] as $t
    ({}; . + { ($t[0]): (.[$t[0]] + { ($t[1]): (.[$t[0]][$t[1]] + [$t[2]]) | unique }) });
  [.[] | [triplet]] | flatten(1) | merge;

def table(lines; cols; inv; txt; fmt):
  def value(line; col; inv):
    if inv then .[col][line] else .[line][col] end;
  def head: [txt.head] + cols;
  def line(line):
    cols[] as $col | value(line; $col; inv) // [txt.empty] | join(txt.space);
  def table:
    head, lines[] as $line | [$line, line($line)];
  table | fmt;

def head_xy: { head: "Lines->Cols" };
def head_yx: { head: "Cols->Lines" };
def txt: { empty: ".", space: "," };
def txt_xy: head_xy + txt;
def txt_yx: head_yx + txt;

def table_xx(set):      table(set;  set;  false; txt_xy; @tsv);
def table_xy(from; to): table(from; to;   false; txt_xy; @tsv);
def table_yx(from; to): table(to;   from; true;  txt_yx; @tsv);
