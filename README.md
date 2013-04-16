SkullSpace tool label generator
===============================

![Default label][label]

This is a script to generate tool labels. For the most basic label

```
./label_maker.sh 3d_printer
```

This will generate a default label linking to skullspace.ca/wiki/index.php/3d_printer, setting SkullSpace as the owner, requiring training, and disallowing hacking.

If the tool is not owned by SkullSpace, you can specify the owner with the -o flag.

```
./label_maker.sh -o "Foo Bar" 3d_printer
```

If training is not required, add the -t flag.

```
./label_maker.sh -t 3d_printer
```

If people are allowed to hack the tool, add -h.

```
./label_maker.sh -h 3d_printer
```

[label]: https://raw.github.com/skullspace/tool_label_generator/master/label.png
