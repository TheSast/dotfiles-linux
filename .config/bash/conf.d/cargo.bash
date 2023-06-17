export CARGO_HOME="$XDG_DATA_HOME/cargo"

# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"/cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="$CARGO_HOME/bin:$PATH"
        ;;
esac
