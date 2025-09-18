package kotlin;

import kotlin.jvm.JvmInline;
import kotlin.jvm.internal.DefaultConstructorMarker;
import kotlin.ranges.ULongRange;

/* compiled from: ULong.kt */
@Metadata(d1 = {"\u0000j\n\u0002\u0018\u0002\n\u0002\u0010\u000f\n\u0000\n\u0002\u0010\t\n\u0002\b\t\n\u0002\u0010\b\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\b\r\n\u0002\u0010\u000b\n\u0002\u0010\u0000\n\u0002\b\"\n\u0002\u0018\u0002\n\u0002\b\u0012\n\u0002\u0010\u0005\n\u0002\b\u0003\n\u0002\u0010\u0006\n\u0002\b\u0003\n\u0002\u0010\u0007\n\u0002\b\u0007\n\u0002\u0010\n\n\u0002\b\u0003\n\u0002\u0010\u000e\n\u0002\b\u000e\b\u0087@\u0018\u0000 |2\b\u0012\u0004\u0012\u00020\u00000\u0001:\u0001|B\u0014\b\u0001\u0012\u0006\u0010\u0002\u001a\u00020\u0003ø\u0001\u0000¢\u0006\u0004\b\u0004\u0010\u0005J\u001b\u0010\b\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\fø\u0001\u0000¢\u0006\u0004\b\n\u0010\u000bJ\u001b\u0010\f\u001a\u00020\r2\u0006\u0010\t\u001a\u00020\u000eH\u0087\nø\u0001\u0000¢\u0006\u0004\b\u000f\u0010\u0010J\u001b\u0010\f\u001a\u00020\r2\u0006\u0010\t\u001a\u00020\u0011H\u0087\nø\u0001\u0000¢\u0006\u0004\b\u0012\u0010\u0013J\u001b\u0010\f\u001a\u00020\r2\u0006\u0010\t\u001a\u00020\u0000H\u0097\nø\u0001\u0000¢\u0006\u0004\b\u0014\u0010\u0015J\u001b\u0010\f\u001a\u00020\r2\u0006\u0010\t\u001a\u00020\u0016H\u0087\nø\u0001\u0000¢\u0006\u0004\b\u0017\u0010\u0018J\u0016\u0010\u0019\u001a\u00020\u0000H\u0087\nø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\b\u001a\u0010\u0005J\u001b\u0010\u001b\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u000eH\u0087\nø\u0001\u0000¢\u0006\u0004\b\u001c\u0010\u001dJ\u001b\u0010\u001b\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0011H\u0087\nø\u0001\u0000¢\u0006\u0004\b\u001e\u0010\u001fJ\u001b\u0010\u001b\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\nø\u0001\u0000¢\u0006\u0004\b \u0010\u000bJ\u001b\u0010\u001b\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0016H\u0087\nø\u0001\u0000¢\u0006\u0004\b!\u0010\"J\u001a\u0010#\u001a\u00020$2\b\u0010\t\u001a\u0004\u0018\u00010%HÖ\u0003¢\u0006\u0004\b&\u0010'J\u001b\u0010(\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u000eH\u0087\bø\u0001\u0000¢\u0006\u0004\b)\u0010\u001dJ\u001b\u0010(\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0011H\u0087\bø\u0001\u0000¢\u0006\u0004\b*\u0010\u001fJ\u001b\u0010(\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\bø\u0001\u0000¢\u0006\u0004\b+\u0010\u000bJ\u001b\u0010(\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0016H\u0087\bø\u0001\u0000¢\u0006\u0004\b,\u0010\"J\u0010\u0010-\u001a\u00020\rHÖ\u0001¢\u0006\u0004\b.\u0010/J\u0016\u00100\u001a\u00020\u0000H\u0087\nø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\b1\u0010\u0005J\u0016\u00102\u001a\u00020\u0000H\u0087\bø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\b3\u0010\u0005J\u001b\u00104\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u000eH\u0087\nø\u0001\u0000¢\u0006\u0004\b5\u0010\u001dJ\u001b\u00104\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0011H\u0087\nø\u0001\u0000¢\u0006\u0004\b6\u0010\u001fJ\u001b\u00104\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\nø\u0001\u0000¢\u0006\u0004\b7\u0010\u000bJ\u001b\u00104\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0016H\u0087\nø\u0001\u0000¢\u0006\u0004\b8\u0010\"J\u001b\u00109\u001a\u00020\u000e2\u0006\u0010\t\u001a\u00020\u000eH\u0087\bø\u0001\u0000¢\u0006\u0004\b:\u0010;J\u001b\u00109\u001a\u00020\u00112\u0006\u0010\t\u001a\u00020\u0011H\u0087\bø\u0001\u0000¢\u0006\u0004\b<\u0010\u0013J\u001b\u00109\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\bø\u0001\u0000¢\u0006\u0004\b=\u0010\u000bJ\u001b\u00109\u001a\u00020\u00162\u0006\u0010\t\u001a\u00020\u0016H\u0087\bø\u0001\u0000¢\u0006\u0004\b>\u0010?J\u001b\u0010@\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\fø\u0001\u0000¢\u0006\u0004\bA\u0010\u000bJ\u001b\u0010B\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u000eH\u0087\nø\u0001\u0000¢\u0006\u0004\bC\u0010\u001dJ\u001b\u0010B\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0011H\u0087\nø\u0001\u0000¢\u0006\u0004\bD\u0010\u001fJ\u001b\u0010B\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\nø\u0001\u0000¢\u0006\u0004\bE\u0010\u000bJ\u001b\u0010B\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0016H\u0087\nø\u0001\u0000¢\u0006\u0004\bF\u0010\"J\u001b\u0010G\u001a\u00020H2\u0006\u0010\t\u001a\u00020\u0000H\u0087\nø\u0001\u0000¢\u0006\u0004\bI\u0010JJ\u001b\u0010K\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u000eH\u0087\nø\u0001\u0000¢\u0006\u0004\bL\u0010\u001dJ\u001b\u0010K\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0011H\u0087\nø\u0001\u0000¢\u0006\u0004\bM\u0010\u001fJ\u001b\u0010K\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\nø\u0001\u0000¢\u0006\u0004\bN\u0010\u000bJ\u001b\u0010K\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0016H\u0087\nø\u0001\u0000¢\u0006\u0004\bO\u0010\"J\u001e\u0010P\u001a\u00020\u00002\u0006\u0010Q\u001a\u00020\rH\u0087\fø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\bR\u0010\u001fJ\u001e\u0010S\u001a\u00020\u00002\u0006\u0010Q\u001a\u00020\rH\u0087\fø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\bT\u0010\u001fJ\u001b\u0010U\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u000eH\u0087\nø\u0001\u0000¢\u0006\u0004\bV\u0010\u001dJ\u001b\u0010U\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0011H\u0087\nø\u0001\u0000¢\u0006\u0004\bW\u0010\u001fJ\u001b\u0010U\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\nø\u0001\u0000¢\u0006\u0004\bX\u0010\u000bJ\u001b\u0010U\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0016H\u0087\nø\u0001\u0000¢\u0006\u0004\bY\u0010\"J\u0010\u0010Z\u001a\u00020[H\u0087\b¢\u0006\u0004\b\\\u0010]J\u0010\u0010^\u001a\u00020_H\u0087\b¢\u0006\u0004\b`\u0010aJ\u0010\u0010b\u001a\u00020cH\u0087\b¢\u0006\u0004\bd\u0010eJ\u0010\u0010f\u001a\u00020\rH\u0087\b¢\u0006\u0004\bg\u0010/J\u0010\u0010h\u001a\u00020\u0003H\u0087\b¢\u0006\u0004\bi\u0010\u0005J\u0010\u0010j\u001a\u00020kH\u0087\b¢\u0006\u0004\bl\u0010mJ\u000f\u0010n\u001a\u00020oH\u0016¢\u0006\u0004\bp\u0010qJ\u0016\u0010r\u001a\u00020\u000eH\u0087\bø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\bs\u0010]J\u0016\u0010t\u001a\u00020\u0011H\u0087\bø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\bu\u0010/J\u0016\u0010v\u001a\u00020\u0000H\u0087\bø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\bw\u0010\u0005J\u0016\u0010x\u001a\u00020\u0016H\u0087\bø\u0001\u0001ø\u0001\u0000¢\u0006\u0004\by\u0010mJ\u001b\u0010z\u001a\u00020\u00002\u0006\u0010\t\u001a\u00020\u0000H\u0087\fø\u0001\u0000¢\u0006\u0004\b{\u0010\u000bR\u0016\u0010\u0002\u001a\u00020\u00038\u0000X\u0081\u0004¢\u0006\b\n\u0000\u0012\u0004\b\u0006\u0010\u0007\u0088\u0001\u0002\u0092\u0001\u00020\u0003ø\u0001\u0000\u0082\u0002\b\n\u0002\b\u0019\n\u0002\b!¨\u0006}"}, d2 = {"Lkotlin/ULong;", "", "data", "", "constructor-impl", "(J)J", "getData$annotations", "()V", "and", "other", "and-VKZWuLQ", "(JJ)J", "compareTo", "", "Lkotlin/UByte;", "compareTo-7apg3OU", "(JB)I", "Lkotlin/UInt;", "compareTo-WZ4Q5Ns", "(JI)I", "compareTo-VKZWuLQ", "(JJ)I", "Lkotlin/UShort;", "compareTo-xj2QHRw", "(JS)I", "dec", "dec-s-VKNKU", "div", "div-7apg3OU", "(JB)J", "div-WZ4Q5Ns", "(JI)J", "div-VKZWuLQ", "div-xj2QHRw", "(JS)J", "equals", "", "", "equals-impl", "(JLjava/lang/Object;)Z", "floorDiv", "floorDiv-7apg3OU", "floorDiv-WZ4Q5Ns", "floorDiv-VKZWuLQ", "floorDiv-xj2QHRw", "hashCode", "hashCode-impl", "(J)I", "inc", "inc-s-VKNKU", "inv", "inv-s-VKNKU", "minus", "minus-7apg3OU", "minus-WZ4Q5Ns", "minus-VKZWuLQ", "minus-xj2QHRw", "mod", "mod-7apg3OU", "(JB)B", "mod-WZ4Q5Ns", "mod-VKZWuLQ", "mod-xj2QHRw", "(JS)S", "or", "or-VKZWuLQ", "plus", "plus-7apg3OU", "plus-WZ4Q5Ns", "plus-VKZWuLQ", "plus-xj2QHRw", "rangeTo", "Lkotlin/ranges/ULongRange;", "rangeTo-VKZWuLQ", "(JJ)Lkotlin/ranges/ULongRange;", "rem", "rem-7apg3OU", "rem-WZ4Q5Ns", "rem-VKZWuLQ", "rem-xj2QHRw", "shl", "bitCount", "shl-s-VKNKU", "shr", "shr-s-VKNKU", "times", "times-7apg3OU", "times-WZ4Q5Ns", "times-VKZWuLQ", "times-xj2QHRw", "toByte", "", "toByte-impl", "(J)B", "toDouble", "", "toDouble-impl", "(J)D", "toFloat", "", "toFloat-impl", "(J)F", "toInt", "toInt-impl", "toLong", "toLong-impl", "toShort", "", "toShort-impl", "(J)S", "toString", "", "toString-impl", "(J)Ljava/lang/String;", "toUByte", "toUByte-w2LRezQ", "toUInt", "toUInt-pVg5ArA", "toULong", "toULong-s-VKNKU", "toUShort", "toUShort-Mh2AYeg", "xor", "xor-VKZWuLQ", "Companion", "kotlin-stdlib"}, k = 1, mv = {1, 7, 1}, xi = 48)
@JvmInline
/* loaded from: classes.dex */
public final class ULong implements Comparable<ULong> {
    public static final Companion Companion = new Companion(null);
    public static final long MAX_VALUE = -1;
    public static final long MIN_VALUE = 0;
    public static final int SIZE_BITS = 64;
    public static final int SIZE_BYTES = 8;
    private final long data;

    /* renamed from: box-impl */
    public static final /* synthetic */ ULong m192boximpl(long j) {
        return new ULong(j);
    }

    /* renamed from: constructor-impl */
    public static long m198constructorimpl(long j) {
        return j;
    }

    /* renamed from: equals-impl */
    public static boolean m204equalsimpl(long j, Object obj) {
        return (obj instanceof ULong) && j == ((ULong) obj).m249unboximpl();
    }

    /* renamed from: equals-impl0 */
    public static final boolean m205equalsimpl0(long j, long j2) {
        return j == j2;
    }

    public static /* synthetic */ void getData$annotations() {
    }

    /* renamed from: hashCode-impl */
    public static int m210hashCodeimpl(long j) {
        return (int) ((j >>> 32) ^ j);
    }

    public boolean equals(Object obj) {
        return m204equalsimpl(this.data, obj);
    }

    public int hashCode() {
        return m210hashCodeimpl(this.data);
    }

    /* renamed from: unbox-impl */
    public final /* synthetic */ long m249unboximpl() {
        return this.data;
    }

    @Override // java.lang.Comparable
    public /* bridge */ /* synthetic */ int compareTo(ULong uLong) {
        return UnsignedKt.ulongCompare(m249unboximpl(), uLong.m249unboximpl());
    }

    private /* synthetic */ ULong(long data) {
        this.data = data;
    }

    /* compiled from: ULong.kt */
    @Metadata(d1 = {"\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0010\b\n\u0002\b\u0002\b\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\b\u0002¢\u0006\u0002\u0010\u0002R\u0016\u0010\u0003\u001a\u00020\u0004X\u0086Tø\u0001\u0000ø\u0001\u0001¢\u0006\u0004\n\u0002\u0010\u0005R\u0016\u0010\u0006\u001a\u00020\u0004X\u0086Tø\u0001\u0000ø\u0001\u0001¢\u0006\u0004\n\u0002\u0010\u0005R\u000e\u0010\u0007\u001a\u00020\bX\u0086T¢\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\bX\u0086T¢\u0006\u0002\n\u0000\u0082\u0002\b\n\u0002\b\u0019\n\u0002\b!¨\u0006\n"}, d2 = {"Lkotlin/ULong$Companion;", "", "()V", "MAX_VALUE", "Lkotlin/ULong;", "J", "MIN_VALUE", "SIZE_BITS", "", "SIZE_BYTES", "kotlin-stdlib"}, k = 1, mv = {1, 7, 1}, xi = 48)
    /* loaded from: classes.dex */
    public static final class Companion {
        public /* synthetic */ Companion(DefaultConstructorMarker defaultConstructorMarker) {
            this();
        }

        private Companion() {
        }
    }

    /* renamed from: compareTo-7apg3OU */
    private static final int m193compareTo7apg3OU(long arg0, byte other) {
        return UnsignedKt.ulongCompare(arg0, m198constructorimpl(other & 255));
    }

    /* renamed from: compareTo-xj2QHRw */
    private static final int m197compareToxj2QHRw(long arg0, short other) {
        return UnsignedKt.ulongCompare(arg0, m198constructorimpl(other & 65535));
    }

    /* renamed from: compareTo-WZ4Q5Ns */
    private static final int m196compareToWZ4Q5Ns(long arg0, int other) {
        return UnsignedKt.ulongCompare(arg0, m198constructorimpl(other & 4294967295L));
    }

    /* renamed from: compareTo-VKZWuLQ */
    private int m194compareToVKZWuLQ(long other) {
        return UnsignedKt.ulongCompare(m249unboximpl(), other);
    }

    /* renamed from: compareTo-VKZWuLQ */
    private static int m195compareToVKZWuLQ(long arg0, long other) {
        return UnsignedKt.ulongCompare(arg0, other);
    }

    /* renamed from: plus-7apg3OU */
    private static final long m222plus7apg3OU(long arg0, byte other) {
        return m198constructorimpl(m198constructorimpl(other & 255) + arg0);
    }

    /* renamed from: plus-xj2QHRw */
    private static final long m225plusxj2QHRw(long arg0, short other) {
        return m198constructorimpl(m198constructorimpl(other & 65535) + arg0);
    }

    /* renamed from: plus-WZ4Q5Ns */
    private static final long m224plusWZ4Q5Ns(long arg0, int other) {
        return m198constructorimpl(m198constructorimpl(other & 4294967295L) + arg0);
    }

    /* renamed from: plus-VKZWuLQ */
    private static final long m223plusVKZWuLQ(long arg0, long other) {
        return m198constructorimpl(arg0 + other);
    }

    /* renamed from: minus-7apg3OU */
    private static final long m213minus7apg3OU(long arg0, byte other) {
        return m198constructorimpl(arg0 - m198constructorimpl(other & 255));
    }

    /* renamed from: minus-xj2QHRw */
    private static final long m216minusxj2QHRw(long arg0, short other) {
        return m198constructorimpl(arg0 - m198constructorimpl(other & 65535));
    }

    /* renamed from: minus-WZ4Q5Ns */
    private static final long m215minusWZ4Q5Ns(long arg0, int other) {
        return m198constructorimpl(arg0 - m198constructorimpl(other & 4294967295L));
    }

    /* renamed from: minus-VKZWuLQ */
    private static final long m214minusVKZWuLQ(long arg0, long other) {
        return m198constructorimpl(arg0 - other);
    }

    /* renamed from: times-7apg3OU */
    private static final long m233times7apg3OU(long arg0, byte other) {
        return m198constructorimpl(m198constructorimpl(other & 255) * arg0);
    }

    /* renamed from: times-xj2QHRw */
    private static final long m236timesxj2QHRw(long arg0, short other) {
        return m198constructorimpl(m198constructorimpl(other & 65535) * arg0);
    }

    /* renamed from: times-WZ4Q5Ns */
    private static final long m235timesWZ4Q5Ns(long arg0, int other) {
        return m198constructorimpl(m198constructorimpl(other & 4294967295L) * arg0);
    }

    /* renamed from: times-VKZWuLQ */
    private static final long m234timesVKZWuLQ(long arg0, long other) {
        return m198constructorimpl(arg0 * other);
    }

    /* renamed from: div-7apg3OU */
    private static final long m200div7apg3OU(long arg0, byte other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, m198constructorimpl(other & 255));
    }

    /* renamed from: div-xj2QHRw */
    private static final long m203divxj2QHRw(long arg0, short other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, m198constructorimpl(other & 65535));
    }

    /* renamed from: div-WZ4Q5Ns */
    private static final long m202divWZ4Q5Ns(long arg0, int other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, m198constructorimpl(other & 4294967295L));
    }

    /* renamed from: div-VKZWuLQ */
    private static final long m201divVKZWuLQ(long arg0, long other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, other);
    }

    /* renamed from: rem-7apg3OU */
    private static final long m227rem7apg3OU(long arg0, byte other) {
        return UnsignedKt.m376ulongRemaindereb3DHEI(arg0, m198constructorimpl(other & 255));
    }

    /* renamed from: rem-xj2QHRw */
    private static final long m230remxj2QHRw(long arg0, short other) {
        return UnsignedKt.m376ulongRemaindereb3DHEI(arg0, m198constructorimpl(other & 65535));
    }

    /* renamed from: rem-WZ4Q5Ns */
    private static final long m229remWZ4Q5Ns(long arg0, int other) {
        return UnsignedKt.m376ulongRemaindereb3DHEI(arg0, m198constructorimpl(other & 4294967295L));
    }

    /* renamed from: rem-VKZWuLQ */
    private static final long m228remVKZWuLQ(long arg0, long other) {
        return UnsignedKt.m376ulongRemaindereb3DHEI(arg0, other);
    }

    /* renamed from: floorDiv-7apg3OU */
    private static final long m206floorDiv7apg3OU(long arg0, byte other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, m198constructorimpl(other & 255));
    }

    /* renamed from: floorDiv-xj2QHRw */
    private static final long m209floorDivxj2QHRw(long arg0, short other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, m198constructorimpl(other & 65535));
    }

    /* renamed from: floorDiv-WZ4Q5Ns */
    private static final long m208floorDivWZ4Q5Ns(long arg0, int other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, m198constructorimpl(other & 4294967295L));
    }

    /* renamed from: floorDiv-VKZWuLQ */
    private static final long m207floorDivVKZWuLQ(long arg0, long other) {
        return UnsignedKt.m375ulongDivideeb3DHEI(arg0, other);
    }

    /* renamed from: mod-7apg3OU */
    private static final byte m217mod7apg3OU(long arg0, byte other) {
        return UByte.m44constructorimpl((byte) UnsignedKt.m376ulongRemaindereb3DHEI(arg0, m198constructorimpl(other & 255)));
    }

    /* renamed from: mod-xj2QHRw */
    private static final short m220modxj2QHRw(long arg0, short other) {
        return UShort.m304constructorimpl((short) UnsignedKt.m376ulongRemaindereb3DHEI(arg0, m198constructorimpl(other & 65535)));
    }

    /* renamed from: mod-WZ4Q5Ns */
    private static final int m219modWZ4Q5Ns(long arg0, int other) {
        return UInt.m120constructorimpl((int) UnsignedKt.m376ulongRemaindereb3DHEI(arg0, m198constructorimpl(other & 4294967295L)));
    }

    /* renamed from: mod-VKZWuLQ */
    private static final long m218modVKZWuLQ(long arg0, long other) {
        return UnsignedKt.m376ulongRemaindereb3DHEI(arg0, other);
    }

    /* renamed from: inc-s-VKNKU */
    private static final long m211incsVKNKU(long arg0) {
        return m198constructorimpl(1 + arg0);
    }

    /* renamed from: dec-s-VKNKU */
    private static final long m199decsVKNKU(long arg0) {
        return m198constructorimpl((-1) + arg0);
    }

    /* renamed from: rangeTo-VKZWuLQ */
    private static final ULongRange m226rangeToVKZWuLQ(long arg0, long other) {
        return new ULongRange(arg0, other, null);
    }

    /* renamed from: shl-s-VKNKU */
    private static final long m231shlsVKNKU(long arg0, int bitCount) {
        return m198constructorimpl(arg0 << bitCount);
    }

    /* renamed from: shr-s-VKNKU */
    private static final long m232shrsVKNKU(long arg0, int bitCount) {
        return m198constructorimpl(arg0 >>> bitCount);
    }

    /* renamed from: and-VKZWuLQ */
    private static final long m191andVKZWuLQ(long arg0, long other) {
        return m198constructorimpl(arg0 & other);
    }

    /* renamed from: or-VKZWuLQ */
    private static final long m221orVKZWuLQ(long arg0, long other) {
        return m198constructorimpl(arg0 | other);
    }

    /* renamed from: xor-VKZWuLQ */
    private static final long m248xorVKZWuLQ(long arg0, long other) {
        return m198constructorimpl(arg0 ^ other);
    }

    /* renamed from: inv-s-VKNKU */
    private static final long m212invsVKNKU(long arg0) {
        return m198constructorimpl(~arg0);
    }

    /* renamed from: toByte-impl */
    private static final byte m237toByteimpl(long arg0) {
        return (byte) arg0;
    }

    /* renamed from: toShort-impl */
    private static final short m242toShortimpl(long arg0) {
        return (short) arg0;
    }

    /* renamed from: toInt-impl */
    private static final int m240toIntimpl(long arg0) {
        return (int) arg0;
    }

    /* renamed from: toLong-impl */
    private static final long m241toLongimpl(long arg0) {
        return arg0;
    }

    /* renamed from: toUByte-w2LRezQ */
    private static final byte m244toUBytew2LRezQ(long arg0) {
        return UByte.m44constructorimpl((byte) arg0);
    }

    /* renamed from: toUShort-Mh2AYeg */
    private static final short m247toUShortMh2AYeg(long arg0) {
        return UShort.m304constructorimpl((short) arg0);
    }

    /* renamed from: toUInt-pVg5ArA */
    private static final int m245toUIntpVg5ArA(long arg0) {
        return UInt.m120constructorimpl((int) arg0);
    }

    /* renamed from: toULong-s-VKNKU */
    private static final long m246toULongsVKNKU(long arg0) {
        return arg0;
    }

    /* renamed from: toFloat-impl */
    private static final float m239toFloatimpl(long arg0) {
        return (float) UnsignedKt.ulongToDouble(arg0);
    }

    /* renamed from: toDouble-impl */
    private static final double m238toDoubleimpl(long arg0) {
        return UnsignedKt.ulongToDouble(arg0);
    }

    /* renamed from: toString-impl */
    public static String m243toStringimpl(long arg0) {
        return UnsignedKt.ulongToString(arg0);
    }

    public String toString() {
        return m243toStringimpl(this.data);
    }
}