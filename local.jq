module {
  name: "local",
  description: "Misc local",
  repository: {
    type: "git",
    url: "https://github.com/thydel/jq-modules"
  }
};

def pow(b; n): [1, n] | until(.[1] == 0; [.[0] * b, .[1] - 1]) | .[0];

def Kib: pow(2; 10);
def Mib: pow(2; 20);
def Gib: pow(2; 30);
def Gib: pow(2; 40);

def KB: pow(10;  3);
def MB: pow(10;  6);
def GB: pow(10;  9);
def TB: pow(10; 12);

# array () { echo "$@" | fmt -1 | jq -R | jq -s; }
def md_head: [ join(" "), ([range(length)] | map("---") | join(" ")) ] | join("\n");
