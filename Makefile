# コンパイラ
COMPILER	= iverilog
# シミュレータ
SIMULATOR	= vvp
# インクルードパスの指定
INCLUDE		= ./src
# 生成されるVCD
VCD			= terc.vcd
# 生成されるVCDの出力ディレクトリ
VCDDIR		= .
# ソースコードの位置
SRCROOT		= ./src
# 中間バイナリファイルの出力ディレクトリ
VVPROOT		= ./vvp
# ソースディレクトリを元に全てのverilogソースをリスト化
SOURCES		= $(wildcard $(SRCROOT)/*.v) $(wildcard $(SRCROOT)/*.sv)

# トップレベルモジュール
ifdef target
	TOPLELVEL = $(target)
else 
	TOPLELVEL = terc
endif

TEST_TL = $(TOPLELVEL)_tb

# vcdのルール
.vcd.vvp:
	$(SIMULATOR) $(VVPROOT)/$(TOPLELVEL).vvp

# vvpのルール
$(TOPLELVEL).vvp: $(SOURCES)
	$(COMPILER) -o $(VVPROOT)/$@ -I $(SRCROOT) -s $(TOPLELVEL) $^

# テストベンチのルール
$(TEST_TL).vvp: $(SOURCES)
	$(COMPILER) -o $(VVPROOT)/$@ -I $(SRCROOT) -s $(TEST_TL) $^

vcd: $(TOPLELVEL).vcd

vvp: $(TOPLELVEL).vvp

run: $(TOPLELVEL).vvp
	$(SIMULATOR) $(VVPROOT)/$(TOPLELVEL).vvp

test: $(TEST_TL).vvp
	$(SIMULATOR) $(VVPROOT)/$(TEST_TL).vvp

all: vcd

clean: 
	rm -f $(VVPS)
