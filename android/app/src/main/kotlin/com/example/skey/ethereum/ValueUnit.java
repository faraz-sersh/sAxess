package com.example.skey.ethereum;

import org.web3j.utils.Convert;

import java.math.BigDecimal;

public interface ValueUnit {
    public BigDecimal toWei();

    class Base implements ValueUnit {
        private final String value;
        private Convert.Unit unit = Convert.Unit.WEI;

        private Base(String value, Convert.Unit unit) {
            this.value = value;
            this.unit = unit;
        }

        @Override
        public BigDecimal toWei() {
            return Convert.toWei(new BigDecimal(value), unit);
        }
    }

    public class Wei extends Base {
        public Wei(String value) {
            super(value, Convert.Unit.WEI);
        }
    }

    public class Kwei extends Base {
        public Kwei(String value) {
            super(value, Convert.Unit.KWEI);
        }
    }

    public class Mwei extends Base {
        public Mwei(String value) {
            super(value, Convert.Unit.MWEI);
        }
    }

    public class Gwei extends Base {
        public Gwei(String value) {
            super(value, Convert.Unit.GWEI);
        }
    }

    public class Szabo extends Base {
        public Szabo(String value) {
            super(value, Convert.Unit.SZABO);
        }
    }

    public class Finney extends Base {
        public Finney(String value) {
            super(value, Convert.Unit.FINNEY);
        }
    }

    public class Ether extends Base {
        public Ether(String value) {
            super(value, Convert.Unit.ETHER);
        }
    }

    public class Kether extends Base {
        public Kether(String value) {
            super(value, Convert.Unit.KETHER);
        }
    }

    public class Mether extends Base {
        public Mether(String value) {
            super(value, Convert.Unit.METHER);
        }
    }

    public class Gether extends Base {
        public Gether(String value) {
            super(value, Convert.Unit.GETHER);
        }
    }

}
