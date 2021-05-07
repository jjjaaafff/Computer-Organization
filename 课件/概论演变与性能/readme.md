# 概论，演变与性能

* 影响程序性能的因素
    * 算法：决定操作的数目
    * 编程语言，编译器：决定每个操作执行的机器指令
    * 处理器与存储器：决定指令执行的速度
    * IO系统：决定IO操作执行的速度

* 组成与架构
    * 架构(Architecture)  
    主要包括四方面：指令集 位数 IO 寻址方式  
    程序员可以看见
    * 组成(Organization)  
    主要包括三方面：控制信号 接口 存储方式  
    电脑拆开后看到的都是组成

* 结构与功能
    * 结构: 部件相互关联的方法
          
        计算机有四种主要结构部件
        * 中央处理单元 (CPU Central Processing Unit)
        * 主存储器 (Main Memory)
        * I/O
        * 系统互连 (System Interconnection)

        CPU内部有四个主要结构部件  
        * 控制单元(Control Unit)
        * 算术逻辑单元(ALU Arithmetic and Login Unit)
        * 寄存器(Register)
        * CPU内部互连(Internal CPU Interconnection)

        控制单元(控制器)内部
        * 时序逻辑 (Sequencing Login)
        * 控制存储器 (Control Memory)
        * 寄存器解码器 (Control Unit Registers and Decoders)
    * 功能: 作为结构组成部分的单个独立部件的操作
        
        计算机基本功能概括包含四项 (COA P24)
        * 数据处理 (Data Processing)
        * 数据存储 (Data Storage)
        * 数据传送 (Data Movement)  
        * 控制 (Control)

* 性能设计

    * 存储器与CPU的性能差距解决

        1. 使用高速缓存(Cache)解决速度差距  
        Cache放在芯片上的原因: 传输距离更短，工作频率提高
        2. Reduce frequency of memory access
        3. Increase number of bits retrieved at one time
        4. Increase interconnection bandwidth

    * 处理器提速

        1. 提高处理器硬件速度  
        减少逻辑门尺寸，提升时钟频率
        2. 提高插入在CPU与主存之间的Cache容量与速度
        3. 更加复杂的执行逻辑(并行处理 parallel execution)
        
        * 存在的障碍
            1. RC延迟(与集成度(逻辑密度)变高矛盾)  
            互连线变细导致电阻增加  
            线排列变紧密导致电容增加
            2. 功耗提高导致散热困难(与提升时钟频率矛盾)  
            发热功率=K(capacity load)*Voltage^2*Frequency  
            电压越高抗噪能力越强，因此电压降低存在限度  
    * 性能的提升是复杂度提升开根号  
    此时处理器内部组成过于复杂，Cache带来的性能提升到达极限  
    ——出现多核 Multiple processors on single chip

* 性能评价

    * 定义表现=执行时间的倒数  
        运行同一个程序，A花10秒，B花15秒，则A是B的1.5倍快
    * 时钟周期(Clock Period)：一个周期的时间
    * 时钟频率(Clock Frequency(rate))：每秒包含的周期数
    * 定义CPU Time = CPU Clock Cycle * Clock Cycle Time  
				  = CPU Clock Cycle / Clock Rate
    * CPI(Average cycles per instruction)每条指令的平均周期数
        * Clock Cycles = Instruction Count * Cycles per Instruction
        * CPU Time = Instruction Count * CPI * Clock Cycle Time  
        其中，指令数(Instruction Count)由程序，ISA和编译器决定  
        CPI的计算可由各类型指令的所需周期与指令数目加权平均得到
    * MIPS(Millions of instructions per second)每秒百万条指令  
        MIPS速度= f / (CPI * 10^6)
    * CPI要求为整数，MIPS可以是分数也可以是小数  


* 阿姆达尔定律(Amdahl’s Law)  
    研究一个程序在使用多处理器与单处理器时可能出现的加速比  
    * 公式描述(PPT_2  P74)  
    1-f表示只能被串行执行的部分，f表示可被无限制并行的部分  
    T表示该程序在单个处理器上的总执行时间  
    N表示使用N个处理器并行处理  
    speedup=在单个处理器执行时间/在N个并行处理器执行时间  
    =(T(1-f)+Tf)/(T(1-f)+Tf/N)  =  1/((1-f)+f/N)
    * 两个结论
      1. 当f非常小时，使用并行处理器只有一点影响
      2. 当N趋近无穷大，加速比被1/(1-f)限制，使用更多处理器使速度下降



