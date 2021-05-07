# 计算机功能与互连

* CPU

    * The Control Unit：将指令转换为控制信号  
    电脑是同步的时序逻辑系统，控制整个电脑的时钟由control unit提供
    * ALU：进行加减，比较等操作
    * CPU通过三总线与外界联系：address bus, data bus, control bus
    * CPU内部使用两个寄存器：
      1. 是存储器地址存储器(MAR)，
      2. 存储器缓冲寄存器(MBR)。  
        目的是与存储器(main memory)之间交换数据
    * 对CPU进行分组(MAR, MBR)和(I/O AR, I/O BR)的原因？  
    为了针对不同的寻址位置，发出I/O Mbar 信号，若为0则在IO取址，若为1则在memory中取址
    * Main memory中的指令与数据为什么不能放在I/O中？  
        一是规定如此，二是main memory中的储存是不变的，写入零则永远是零；I/O则不是这样，会发生改变

* 指令周期：一条指令所要求的处理过程

    两个单元循环运行，取指周期(Fetch)和执行周期(Execute)
    * 取指周期

        * 程序计数器(PC)  
            相当于指针，指向指令的第一个字节，保存着下一个指令的地址  
            转向下一个指令时，PC=PC + sizeof(instruction)字节长度  
            发生跳转时则不加长度
        * 指令寄存器(IR)  
            指令的值存入其中  
            指令进入IR的前提是该指令的地址来自PC
    
    * 执行周期
        * 指令为四种操作的混合  
            * Processor-memory  
            * processor-I/O  
            * data processing  
            * control

            前两个为CPU外部，通过三总线；后两个为CPU内部  

        Return for string：取指后多次执行，FE1E2E3… 实际同属一条指令下执行

* CPU与IO设备通信有三种方法
    1. 查询：Calling 通过程序看IO设备是否准备好了
    2. 中断：IO通过发送信号告诉CPU完成
    3. DMA(direct memory access)：IO的数据直接送到memory中，不通过CPU，此时CPU释放对三总线的控制

* 中断机制
    * 是一种机制(Mechanism)，IO中断通常程序执行(FEFEFE..)，将CPU资源拿过来使用。提升了处理效率  
    有了中断，处理器可以在IO操作进行的时候执行其他命令  
    外围设备发送Interrupt request至CPU，若CPU响应该中断，则提供一个
    acknowledge至外部设备(握手信号)
    * 长IO等待
    前一次对IO操作未完成下一个操作又来了，此时CPU进行等待。直到前一个操作完成，硬盘发出信号后CPU继续工作马上跳到下一次操作
    * CPU如何支持中断？
    指令周期加入中断cycle  在每条指令结束之后check for interrupt  
    检测是否有中断信号：上升沿、下降沿、高低电平任意一种  
    若存在中断，执行五个程序流程(软硬件结合)
      1. Suspend execution of current program
      2. Save context(包括PC，PSW状态字 等等)
      3. Set PC to start address of interrupt handler routine
      4. Process interrupt(软件操控，其余均为硬件)
      5. Restore context and continue interrupted program
    * 多重中断
        根据中断请求的紧急程度，允许被嵌套中断(笔记本)
    
* 互连(Interconnection)  
    计算机包含三个基本类型模块(CPU, memory, IO)，各模块相互连接
    * 存储器(Memory)  
    接收数据、地址、控制信号(读，写，时序(各信号相对时间)) 发送数据  
    内部由N个等长的字组成，每个字分配了唯一的数值地址  
    若已知地址位数，则可寻址的存储器容量为2的该次方  
    * I/O模块  
    在功能上与memory类似。address线的数目差别大，IO的线少  
    一个IO模块可控制多个外设 可定义每个与外部设备的接口为端口，也叫端口地址，通过address bus用来表征连向外围的设备  
    IO模块还可以向CPU发送中断信号(通过control bus)  
    I/O module不包括硬盘。硬盘通过USB或者SATA接到IO接口，IO module的范围到接口为止，包含接口
    * CPU  
    CPU和memory之间的通信传输的是指令和数据  
    CPU和IO之间传输的是数据和控制信号(控制命令，二进制)  
    控制信号是IO与memory传送数据最大的不同  
    可通过判断读写是否一致来确定与CPU连接的结构 

* 总线(Bus)  
    连接两个或多个设备的通信线路，关键特征是共享传输介质  
    类似广播，任何设备发出的信号可被其他所有连接到总线的设备接收  
    每次只能有一个设备利用总线发送，不能同时发送  
    * 数据总线  
    用于承载数据和指令  
    其本身无法区分传的是数据还是指令，都是二进制的值  
    总线中数据线的数目成为数据总线的宽度，每条线每次传送一位  
    数据总线宽度关键地决定系统总体性能(一次能传送的位数)  
    若宽度过大，则设计复杂，扰乱balance
    * 地址总线  
    用于指定数据总线上数据的来源或去向  
    地址总线宽度决定了系统能够使用的最大的存储器容量  
    16bit地址线对应的内存单元数目为64k(2的16次方)  
    一个内存单元(空间)在memory或IO中的大小为8bit  
    若用8bit数据总线传输，则需要遍历整个内存空间需要读或写64k次
    * 控制总线  
    控制对数据线和地址线的存取和使用
    * 单总线存在的问题  
    总线上设备越多，总线长度越长，传输延迟越大  
    聚集的传输请求接近总线容量时，总线成为瓶颈

* 单位换算  
    1M=2的20次方  
    1G=2的30次方  
    1字节(Byte, B) = 8位(bit, b)  
    一个字由若干个字节(4个)构成





