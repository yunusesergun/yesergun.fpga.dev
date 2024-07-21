# Wavedrom

There is an application called `Wavedrom`. This application allows us to draw waveforms, simple logic circuits, and bitfields. We use `JSON` to create these drawings. Using such an application is very helpful when writing documentation. You don't need to know JSON (I don't know much either). This tutorial will be sufficient for drawing waveforms.

It is a very easy program to use, especially for RTL designers to draw the protocols they use when writing documentation. It has a very simple syntax, making it quite easy to learn. In this article, I will explain how to draw waveforms using this application. Since I have not used it to draw logic circuits and bitfields, I will not go into detail on those parts.

## How to Install

We can use it online from [this link](https://wavedrom.com/editor.html), but I will also explain how to download it to your computer.

Downloading and opening it is very easy. I used it on Windows 10. Therefore, I will only explain how to download and use it on Windows 10. Since it is essentially a GitHub repository, you need to download the necessary .zip file from Release section. I have shared the link to Release page below:

[Wavedrom Download Link](https://github.com/wavedrom/wavedrom.github.io/releases)

I used version 3.4.0 (currently the most recent version). So, I downloaded the file named `wavedrom-editor-v3.4.0-win-x64.zip`.

In terms of usage, you can extract the .zip file and copy it anywhere on your computer. Then, you can open the program by running `wavedrom-editor.exe`.

## Example Demonstration

As an example, here is a wavedrom drawing showing `AXI4-Stream` protocol:

![axi4stream](./assets/wavedrom.svg)

The source code for the wavedrom visual I shared above is given below:

```text
{
  signal: [
    // clk signal properties
    {
        name: 'clk',
        wave: 'p.|...........'
    },
    {
        node: 'cd............'
    },
    // rst_n signal properties
    {
        name: 'rst_n',
        wave: '10|1..........'
    },
    // axis_tvalid signal properties
    {
        name: 'axis_tvalid',
        wave: '0.|..1...0..10'
    },
    {
        node: '.........a..b.'
    },
    // axis_tready signal properties
    {
        name: 'axis_tready',
        wave: '0.|.1.0.1.....'
    },
    // axis_tdata signal properties
    {
        name: 'axis_tdata',
        wave: 'x.|..34..x..5x',
        data: ['head', 'body', 'tail']
    }
  ],
  config: { hscale: 2 },
  edge: [
    'a<->b SOME DELAY',
    'c<->d 40 ns'
  ]
}
```

Let's break down the code above and see how it was written:

## Signal Definition

To define signals and add various properties related to drawing, `signal[]` key is used. Then, for each line we will create on waveform, we use `{}` brackets, and after each bracket, we need to put a comma until last line. These situations are related to `.json` syntax. It is not a rule specific to Wavedrom.

Items we can define within brackets are limited but sufficient. `name`, `wave`, `node`, `data`, `period`, and `phase` can be defined. I did not see any item name other than these that Wavedrom application understands. These six items are already sufficient.

## Using "name"

`name` defines signal name. After `name:` expression, we write signal name we want to define in quotation marks. Below is an example of JSON code:

```text
{
  signal: [
    // Signal properties
    {
        name: 'example_signal'
    }
  ]
}
```

After this code, we can see an image like the one below in Wavedrom application:

![capture2](./assets/wavedrom2.svg)

## Using "wave" and "data"

As clearly seen in the image above, there is a signal definition but no waveform. To define a waveform, we need to define `wave` item within same bracket. Below is an example code:

```text
{
  signal: [
    // Signal properties
    {
        name: 'example_signal',
        wave: '..............'
    }
  ]
}
```

After this code, we can see an image like the one below in Wavedrom application:

![capture3](./assets/wavedrom3.svg)

As you can see, since no value has been defined for the signal, it appears as `Don't Care`. The dot within the quotation marks is used to continue last defined signal value, so we don't need to redefine signal for each cycle.

- Note: If you want signal to appear as `Don't Care` in different cycles, even if signal value is defined, you can use `x` mark.

I have listed the types of signals that can be defined with "wave" below:

- By defining `0` and `1`, we can obtain signals that we can see in real life. What is meant by real life is that setup and hold times of signals are more clearly visible, but it is not possible to adjust setup and hold times. Below is an example code and waveform:

```text
{
  signal: [
    // Signal properties
    {
        name: 'example_signal',
        wave: '01............'
    }
  ]
}
```

![capture4](./assets/wavedrom4.svg)

- By defining `p` and `n`, we can produce a periodic signal starting with a positive-negative edge. Below is an example code and waveform:

```text
{
  signal: [
    // Signal properties
    {
        name: 'example_signal',
        wave: '.n............'
    }
  ]
}
```

![capture5](./assets/wavedrom5.svg)

- By defining `P` and `N`, we can produce a clock signal starting with a positive-negative edge. Expression `P` indicates that we sample signals with a rising-edge, and expression `N` indicates that we sample signals with a falling-edge. Below is an example code and waveform:

```text
{
  signal: [
    // Signal properties
    {
        name: 'example_signal',
        wave: '.n............'
    }
  ]
}
```

![capture7](./assets/wavedrom7.svg)

- `data` can be defined by using numbers from 2 to 9. Additionally, we can define a new key named `data:` and write desired text in data part with square brackets. Below is an example code and waveform:

```text
{
  signal: [
    // Signal properties
    {
        name: 'example_signal',
        wave: 'x2.3.4.5.6.7.8.9.',
        data: ['2', '3', '4', '5', '6', '7', '8', '9']
    }
  ]
}
```

![capture6](./assets/wavedrom6.svg)

- We can use `|` expression to indicate signals that remain the same for a long time. This way, we optimize waveform. Below is an example code and waveform:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: '.n...|........'
    },
    // Signal-2 properties
    {
        name: 'example_signal-2',
        wave: '1..01|........'
    }
  ]
}
```

![capture17](./assets/wavedrom17.svg)

## Using "period"

By using `period`, size of the relevant signal can be enlarged according to defined value. In this case, quotation marks are not needed. All natural numbers except zero can be used. Below is an example code and waveform:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: 'P................',
        period: 2
    },
    {},
    // Signal-2 properties
    {
        name: 'example_signal-2',
        wave: 'x2.3.4.5.6.7.8.9.',
        data: ['2', '3', '4', '5', '6', '7', '8', '9']
    }
  ]
}
```

![capture9](./assets/wavedrom9.svg)

In the above example, the period of `example_signal-1` signal has been increased by 2 times compared to the default.

## Using "phase"

With `phase`, it is possible to give phase. To achieve a phase shift equal to 1 period value (360 degrees), you need to give a value of 1. In other words, one period fits between the values of 0 and 1. As with `period` key, quotation marks are not used here. Below is an example code and waveform:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: 'P................',
        period: 1,
        phase: 0.2
    },
    {},
    // Signal-2 properties
    {
        name: 'example_signal-2',
        wave: 'x2.3.4.5.6.7.8.9.',
        data: ['2', '3', '4', '5', '6', '7', '8', '9']
    }
  ]
}
```

![capture10](./assets/wavedrom10.svg)

## Using "node"

With `node`, it is possible to make representations with arrows for signals on a new line. Although wavedrom application's guide shows in detail what can be done, I will show a brief example. For more complex uses, I recommend examining the guide they shared.

To use `node`, we need to define `edge` in addition to `signal`. In this area, we first define letter that will appear at the end of arrow within quotation marks. Then, we write expression that will appear between arrows by leaving a space. Below is an example code and waveform:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: 'P................',
        period: 2,
        phase: 0
    },
    {
        node: 'c.d............'
    },
  ],
  edge: [
    'c<->d 40 ns'
  ]
}
```

![capture11](./assets/wavedrom11.svg)

## Other Features

In addition to these; if we want to create a gap between two signals (2 rows), it is enough to put empty brackets. Below is an example code and waveform:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: 'P................'
    },
    {},
    // Signal-2 properties
    {
        name: 'example_signal-2',
        wave: 'x2.3.4.5.6.7.8.9.',
        data: ['2', '3', '4', '5', '6', '7', '8', '9']
    }
  ]
}
```

![capture8](./assets/wavedrom8.svg)

Finally, we can play with scaling in a way that affects all signals. To do this, we write an area called `config`, similar to `signal` and `edge`, and define `hscale` in it. Unlike `signal`, we do not need to use square brackets when making `config` definition. Below is an example code and waveform:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: 'P................',
        period: 1,
        phase: 0
    },
    {
        node: 'cd...............'
    },
    // Signal-2 properties
    {
        name: 'example_signal-2',
        wave: 'x2.3.4.5.6.7.8.9.',
        data: ['2', '3', '4', '5', '6', '7', '8', '9']
    }
  ],
  config: { hscale: 2 },
  edge: [
    'c<->d 40 ns'
  ]
}
```

![capture12](./assets/wavedrom12.svg)

Below is the code and waveform with `hscale: 4`:

```text
{
  signal: [
    // Signal-1 properties
    {
        name: 'example_signal-1',
        wave: 'P......',
        period: 1,
        phase: 0
    },
    {
        node: 'cd..........'
    },
    // Signal-2 properties
    {
        name: 'example_signal-2',
        wave: 'x2.3.4.',
        data: ['2', '3', '4', '5', '6', '7', '8', '9']
    }
  ],
  config: { hscale: 4 },
  edge: [
    'c<->d 40 ns'
  ]
}
```

![capture13](./assets/wavedrom13.svg)

I have explained a lot, but there is also the wavedrom guide they published. It talks about more detailed features and uses. To open it, you can find the guide in area indicated in the image below:

![capture14](./assets/wavedrom14.png)

## Final Notes

The program is excellent for documentation work and building architecture at module level. In addition to this, it can also draw simple `logic circuits`. However, I have not yet experienced this feature. I think it can be used in many places. Below, I have added the example code and logic circuit image they shared:

```text
{ assign:[
  ["out",
    ["|",
      ["&", ["~", "a"], "b"],
      ["&", ["~", "b"], "a"]
    ]
  ]
]}
```

![capture15](./assets/wavedrom15.png)

There is also a `bitfield` drawing feature. I have not experienced this feature either, but it looks very good visually and is really easy to use. Thanks to bitfield feature, we can define content of packet such as ethernet packet. Below, I have added the example code and bitfield image they shared:

```text
{
    reg: [
        {
            bits: 7,
            name: 'opcode',
            attr: 'OP-IMM'
        },
        {
            bits: 5,
            name: 'rd',
            attr: 'dest'
        },
        {
            bits: 3,
            name: 'func3',
            attr: ['ADDI', 'SLTI', 'SLTIU', 'ANDI', 'ORI', 'XORI'],
            type: 4
        },
        {
            bits: 5,
            name: 'rs1',
            attr: 'src'
        },
        {
            bits: 12,
            name: 'imm[11:0]',
            attr: 'I-immediate[11:0]',
            type: 3
        }
  ],
  config: {hspace: 2}
}
```

![capture16](./assets/wavedrom16.png)

Bitfield usage is quite similar to what I have explained throughout the tutorial. It seems that `reg` has been used instead of `signal`. Additionally, the features of `bits`, `attr`, and `type` have been added.

## References

- [Wavedrom Release Page](https://github.com/wavedrom/wavedrom.github.io/releases)
- [Wavedrom GitHub Page](https://github.com/wavedrom/wavedrom.github.io)
- [Online Wavedrom Page](https://wavedrom.com/editor.html)
- [Wavedrom Tutorial](https://wavedrom.com/images/SNUG2016_WaveDrom.pdf)
- [Wavedrom Signal Tutorial Page](https://wavedrom.com/tutorial.html)
- [Wavedrom Logic Circuit Tutorial Page](https://wavedrom.com/tutorial2.html)
